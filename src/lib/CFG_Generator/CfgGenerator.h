#ifndef CFG_GENERATOR_CFGGENERATOR_H_
#define CFG_GENERATOR_CFGGENERATOR_H_

#include "llvm/Pass.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Value.h"

#include <cstdio>
#include <cstdlib>
#include <string>
#include <list>
#include <map>

using namespace std;
using namespace llvm;

class CfgGenerator: public FunctionPass {
private:
  map<Value*, string> valuesMap;
  list<string> successorsList;
  int instrCount= 0;
  static const string BASIC_BLOCK_PREFIX;
  static const string INSTRUCTION_PREFIX;
  static const string FUNCTION_PREFIX;

public:
  static char ID;
  CfgGenerator() : FunctionPass(ID) {}
  ~CfgGenerator() {
  }

  virtual bool runOnFunction(Function &function);

  string generateLabel(Value* id, string prefix);
  string getPhiNodeValueLabel(Value* instruction, string prefix);
  string getConstantValue(Constant* value);

  string phiNodeInstToString(PHINode* phiNode);
  string branchInstToString(BranchInst* branchInst, string basicBlockLabel);
  string callInstToString(CallInst* callInst);
  string returnInstToString(ReturnInst *returnInst);
  string generalInstToString(Instruction& inst);

  void generateCfgDotFile(Function &function);
};

#endif /* CFG_GENERATOR_CFGGENERATOR_H_ */
