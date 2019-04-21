#include "llvm/IR/PassManager.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/InstrTypes.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/ADT/StringRef.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Debug.h"

#include <iostream>
#include <fstream>

#include "CfgGenerator.h"

#define DEBUG_TYPE "CfgGenerator"

const string CfgGenerator::BASIC_BLOCK_PREFIX = "BB";
const string CfgGenerator::INSTRUCTION_PREFIX = "%";
const string CfgGenerator::FUNCTION_PREFIX = "@";

string CfgGenerator::generateLabel(Value *id, string prefix)
{
  map<Value *, string>::iterator it = valuesMap.find(id);
  string label;
  if (it == valuesMap.end())
  {
    string strId = id->getName();
    if ((strId.compare("argc") != 0) && (strId.compare("argv") != 0) && prefix.compare(FUNCTION_PREFIX) != 0)
    {
      label = prefix + to_string(instrCount);
      ++instrCount;
    }
    else
    {
      label = prefix + strId;
    }
    valuesMap[id] = label;
  }
  else
  {
    label = it->second;
  }

  return label;
}

string CfgGenerator::getPhiNodeValueLabel(Value *instruction, string prefix)
{
  map<Value *, string>::iterator it = valuesMap.find(instruction);
  string instructionLabel = instruction->getName();
  
  if (it != valuesMap.end())
  {
    instructionLabel = it->second;
  }
  else 
  {
    if(instructionLabel != "")
    {
      instructionLabel = prefix + instructionLabel;
    }
    else{
      instructionLabel = prefix + to_string(instrCount);
      ++instrCount;
    }
    valuesMap[instruction] = instructionLabel;
  } 

  return instructionLabel;
}

string CfgGenerator::getConstantValue(Constant *value)
{
  string strValue = value->getName();

  if (ConstantInt *CI = dyn_cast<ConstantInt>(value))
  {
    strValue = CI->getValue().toString(10, true);
  }
  else if (ConstantFP *CFP = dyn_cast<ConstantFP>(value))
  {
    if (CFP->getType()->isFloatTy())
    {
      strValue = to_string((&CFP->getValueAPF())->convertToFloat());
    }
    else
    {
      strValue = to_string((&CFP->getValueAPF())->convertToDouble());
    }
  }

  return strValue;
}

string CfgGenerator::phiNodeInstToString(PHINode *phiNode)
{
  string strPhi;
  for (int p = 0; p < phiNode->getNumIncomingValues(); p++)
  {
    strPhi.append(" [ ");
    Value *incomingValue = phiNode->getIncomingValue(p);

    if (Constant *constValue = dyn_cast<Constant>(incomingValue))
    {
      string strConst = getConstantValue(constValue);
      if (strConst.compare("") != 0)
      {
        strPhi.append(strConst);
      }
    }
    else
    {
      if (PHINode *phiNode = dyn_cast<PHINode>(incomingValue))
        strPhi.append(getPhiNodeValueLabel(incomingValue, INSTRUCTION_PREFIX));
      else
        strPhi.append(generateLabel(incomingValue, INSTRUCTION_PREFIX));
    }

    strPhi.append(", ");
    strPhi.append(generateLabel(phiNode->getIncomingBlock(p), BASIC_BLOCK_PREFIX));
    strPhi.append(" ] ");
    strPhi.append(",");
  }
  strPhi.erase(strPhi.end() - 1);

  return strPhi;
}

string CfgGenerator::branchInstToString(BranchInst *branchInst, string basicBlockLabel)
{
  string strBranchInst = branchInst->getOpcodeName();
  if (branchInst->isConditional())
  {
    strBranchInst.append(" ");
    strBranchInst.append(valuesMap[branchInst->getCondition()]);
  }
  unsigned numSuccessors = branchInst->getNumSuccessors();
  for (int i = 0; i < numSuccessors; i++)
  {
    string successorLabel = generateLabel(branchInst->getSuccessor(i), BASIC_BLOCK_PREFIX);
    strBranchInst.append(" ");
    strBranchInst.append(successorLabel);
    successorsList.push_back((basicBlockLabel + " -> " + successorLabel));
  }

  return strBranchInst;
}

string CfgGenerator::returnInstToString(ReturnInst *returnInst)
{
  string strReturn = returnInst->getOpcodeName();
  for (int i = 0; i < returnInst->getNumOperands(); i++)
  {
    Value *operandValue = returnInst->getOperand(i);
    strReturn.append(" ");

    if (Constant *constValue = dyn_cast<Constant>(operandValue))
    {
      string strConst = getConstantValue(constValue);
      if (strConst.compare("") != 0)
      {
        strReturn.append(strConst);
      }
    }
    else
    {
      map<Value *, string>::iterator it = valuesMap.find(operandValue);
      string label;
      if (it != valuesMap.end())
        strReturn.append(it->second);
      else
        strReturn.append(operandValue->getName());
    }
  }

  return strReturn;
}

string CfgGenerator::callInstToString(CallInst *callInst)
{
  string strCall = generateLabel(callInst, INSTRUCTION_PREFIX);
  strCall.append(" = ");
  strCall.append(callInst->getOpcodeName()).append(" ");

  Function *fun = callInst->getCalledFunction();
  strCall.append(generateLabel(fun, FUNCTION_PREFIX));
  strCall.append("( ");

  int numOps = callInst->getNumOperands();
  for (int idx = numOps - 2; idx >= 0; idx--)
  {
    Value *operandValue = callInst->getOperand(idx);
    if (Constant *constValue = dyn_cast<Constant>(operandValue))
    {
      string strConst = getConstantValue(constValue);
      if (strConst.compare("") != 0)
      {
        strCall.append(strConst);
        strCall.append(",");
      }
    }
    else if (!isa<GetElementPtrInst>(operandValue))
    {
      strCall.append(generateLabel(operandValue, INSTRUCTION_PREFIX));
      strCall.append(",");
    }
  }
  strCall.erase(strCall.end() - 1);
  strCall.append(")");

  return strCall;
}

string CfgGenerator::generalInstToString(Instruction &inst)
{
  string strInst;
  string instructionLabel = generateLabel(&inst, INSTRUCTION_PREFIX);
  strInst.append(instructionLabel);
  strInst.append(" = ");
  strInst.append(inst.getOpcodeName());

  if (CmpInst *cmpInst = dyn_cast<CmpInst>(&inst))
  {
    strInst.append("-");
    strInst.append(cmpInst->getPredicateName(cmpInst->getPredicate()));
  }

  int numOps = inst.getNumOperands();
  for (int idx = 0; idx < numOps; idx++)
  {
    Value *operandValue = inst.getOperand(idx);
    if (Constant *constValue = dyn_cast<Constant>(operandValue))
    {
      string strConst = getConstantValue(constValue);
      if (strConst.compare("") != 0)
      {
        strInst.append(" ");
        strInst.append(strConst);
        strInst.append(",");
      }
    }
    else
    {
      strInst.append(" ");
      strInst.append(generateLabel(operandValue, INSTRUCTION_PREFIX));
      strInst.append(",");
    }
  }
  strInst.erase(strInst.end() - 1);

  return strInst;
}

void CfgGenerator::generateCfgDotFile(Function &function)
{
  bool changed = false;
  string functionName = function.getName();
  string fileName = functionName + ".dot";
  ofstream cfgFile(fileName);

  if (cfgFile.is_open())
  {
    cfgFile << "digraph \"CFG for \'" << functionName << "\' function\" {\n";
    for (BasicBlock &basicBlock : function)
    {
      string basicBlockName = basicBlock.getName();
      string basicBlockLabel = generateLabel(&basicBlock, BASIC_BLOCK_PREFIX);

      cfgFile << basicBlockLabel << " [shape=record,\n";
      cfgFile << "    label=\"{" << basicBlockLabel << ":\\l\\l\n";

      for (Instruction &instruction : basicBlock)
      {
        if (BranchInst *branchInst = dyn_cast<BranchInst>(&instruction))
        {
          cfgFile << "             " << branchInstToString(branchInst, basicBlockLabel) << "\\l\n";
        }
        else if (PHINode *phiNode = dyn_cast<PHINode>(&instruction))
        {

          string strPhi = getPhiNodeValueLabel(&instruction, INSTRUCTION_PREFIX);
          strPhi.append(" = ");
          strPhi.append(instruction.getOpcodeName());
          strPhi.append(phiNodeInstToString(phiNode));

          cfgFile << "             " << strPhi << "\\l\n";
        }
        else if (ReturnInst *returnInst = dyn_cast<ReturnInst>(&instruction))
        {
          cfgFile << "             " << returnInstToString(returnInst) << "\\l\n";
        }
        else if (CallInst *callInst = dyn_cast<CallInst>(&instruction))
        {
          string strCall = callInstToString(callInst);
          cfgFile << "             " << strCall << "\\l\n";
        }
        else
        {
          string strInst = generalInstToString(instruction);
          cfgFile << "             " << strInst << "\\l\n";
        }
      }
      cfgFile << "             }\"];\n";

      while (!successorsList.empty())
      {
        cfgFile << successorsList.front() << "\n";
        successorsList.pop_front();
      }
    }
    cfgFile << "}";
    cfgFile.close();
  }
  else
  {
    cout << "Unable to open file";
  }
}

bool CfgGenerator::runOnFunction(Function &function)
{
  if (function.isDeclaration() || function.empty())
    return false;

  generateCfgDotFile(function);
  return false;
}

char CfgGenerator::ID = 0;
static RegisterPass<CfgGenerator> X("cfg-generator", "CFG Generator Pass - Generates a dot file for each function of the being analysed.");
