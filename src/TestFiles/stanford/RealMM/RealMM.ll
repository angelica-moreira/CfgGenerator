; ModuleID = '<stdin>'
source_filename = "/Users/angelicamoreira/UFMG/StaticAnalysis/TP1/CfgGenerator/src/TestFiles/stanford/RealMM/RealMM.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.14.0"

%struct.node = type { %struct.node*, %struct.node*, i32 }
%struct.element = type { i32, i32 }
%struct.complex = type { double, double }

@seed = common global i64 0, align 8
@rma = common global [41 x [41 x double]] zeroinitializer, align 16
@rmb = common global [41 x [41 x double]] zeroinitializer, align 16
@rmr = common global [41 x [41 x double]] zeroinitializer, align 16
@.str = private unnamed_addr constant [4 x i8] c"%f\0A\00", align 1
@value = common global double 0.000000e+00, align 8
@fixed = common global double 0.000000e+00, align 8
@floated = common global double 0.000000e+00, align 8
@permarray = common global [11 x i32] zeroinitializer, align 16
@pctr = common global i32 0, align 4
@tree = common global %struct.node* null, align 8
@stack = common global [4 x i32] zeroinitializer, align 16
@cellspace = common global [19 x %struct.element] zeroinitializer, align 16
@freelist = common global i32 0, align 4
@movesdone = common global i32 0, align 4
@ima = common global [41 x [41 x i32]] zeroinitializer, align 16
@imb = common global [41 x [41 x i32]] zeroinitializer, align 16
@imr = common global [41 x [41 x i32]] zeroinitializer, align 16
@piececount = common global [4 x i32] zeroinitializer, align 16
@class = common global [13 x i32] zeroinitializer, align 16
@piecemax = common global [13 x i32] zeroinitializer, align 16
@puzzl = common global [512 x i32] zeroinitializer, align 16
@p = common global [13 x [512 x i32]] zeroinitializer, align 16
@n = common global i32 0, align 4
@kount = common global i32 0, align 4
@sortlist = common global [5001 x i32] zeroinitializer, align 16
@biggest = common global i32 0, align 4
@littlest = common global i32 0, align 4
@top = common global i32 0, align 4
@z = common global [257 x %struct.complex] zeroinitializer, align 16
@w = common global [257 x %struct.complex] zeroinitializer, align 16
@e = common global [130 x %struct.complex] zeroinitializer, align 16
@zr = common global double 0.000000e+00, align 8
@zi = common global double 0.000000e+00, align 8

; Function Attrs: noinline nounwind ssp uwtable
define void @Initrand() #0 {
entry:
  store i64 74755, i64* @seed, align 8
  ret void
}

; Function Attrs: noinline nounwind ssp uwtable
define i32 @Rand() #0 {
entry:
  %0 = load i64, i64* @seed, align 8
  %mul = mul nsw i64 %0, 1309
  %add = add nsw i64 %mul, 13849
  %and = and i64 %add, 65535
  store i64 %and, i64* @seed, align 8
  %1 = load i64, i64* @seed, align 8
  %conv = trunc i64 %1 to i32
  ret i32 %conv
}

; Function Attrs: noinline nounwind ssp uwtable
define void @rInitmatrix([41 x double]* %m) #0 {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.inc8, %entry
  %i.0 = phi i32 [ 1, %entry ], [ %inc9, %for.inc8 ]
  %cmp = icmp sle i32 %i.0, 40
  br i1 %cmp, label %for.body, label %for.end10

for.body:                                         ; preds = %for.cond
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc, %for.body
  %j.0 = phi i32 [ 1, %for.body ], [ %inc, %for.inc ]
  %cmp2 = icmp sle i32 %j.0, 40
  br i1 %cmp2, label %for.body3, label %for.end

for.body3:                                        ; preds = %for.cond1
  %call = call i32 @Rand()
  %div = sdiv i32 %call, 120
  %mul = mul nsw i32 %div, 120
  %sub = sub nsw i32 %call, %mul
  %sub4 = sub nsw i32 %sub, 60
  %conv = sitofp i32 %sub4 to double
  %div5 = fdiv double %conv, 3.000000e+00
  %idxprom = sext i32 %i.0 to i64
  %arrayidx = getelementptr inbounds [41 x double], [41 x double]* %m, i64 %idxprom
  %idxprom6 = sext i32 %j.0 to i64
  %arrayidx7 = getelementptr inbounds [41 x double], [41 x double]* %arrayidx, i64 0, i64 %idxprom6
  store double %div5, double* %arrayidx7, align 8
  br label %for.inc

for.inc:                                          ; preds = %for.body3
  %inc = add nsw i32 %j.0, 1
  br label %for.cond1

for.end:                                          ; preds = %for.cond1
  br label %for.inc8

for.inc8:                                         ; preds = %for.end
  %inc9 = add nsw i32 %i.0, 1
  br label %for.cond

for.end10:                                        ; preds = %for.cond
  ret void
}

; Function Attrs: noinline nounwind ssp uwtable
define void @rInnerproduct(double* %result, [41 x double]* %a, [41 x double]* %b, i32 %row, i32 %column) #0 {
entry:
  store double 0.000000e+00, double* %result, align 8
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i32 [ 1, %entry ], [ %inc, %for.inc ]
  %cmp = icmp sle i32 %i.0, 40
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %0 = load double, double* %result, align 8
  %idxprom = sext i32 %row to i64
  %arrayidx = getelementptr inbounds [41 x double], [41 x double]* %a, i64 %idxprom
  %idxprom1 = sext i32 %i.0 to i64
  %arrayidx2 = getelementptr inbounds [41 x double], [41 x double]* %arrayidx, i64 0, i64 %idxprom1
  %1 = load double, double* %arrayidx2, align 8
  %idxprom3 = sext i32 %i.0 to i64
  %arrayidx4 = getelementptr inbounds [41 x double], [41 x double]* %b, i64 %idxprom3
  %idxprom5 = sext i32 %column to i64
  %arrayidx6 = getelementptr inbounds [41 x double], [41 x double]* %arrayidx4, i64 0, i64 %idxprom5
  %2 = load double, double* %arrayidx6, align 8
  %mul = fmul double %1, %2
  %add = fadd double %0, %mul
  store double %add, double* %result, align 8
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %inc = add nsw i32 %i.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  ret void
}

; Function Attrs: noinline nounwind ssp uwtable
define void @Mm(i32 %run) #0 {
entry:
  call void @Initrand()
  call void @rInitmatrix([41 x double]* getelementptr inbounds ([41 x [41 x double]], [41 x [41 x double]]* @rma, i32 0, i32 0))
  call void @rInitmatrix([41 x double]* getelementptr inbounds ([41 x [41 x double]], [41 x [41 x double]]* @rmb, i32 0, i32 0))
  br label %for.cond

for.cond:                                         ; preds = %for.inc6, %entry
  %i.0 = phi i32 [ 1, %entry ], [ %inc7, %for.inc6 ]
  %cmp = icmp sle i32 %i.0, 40
  br i1 %cmp, label %for.body, label %for.end8

for.body:                                         ; preds = %for.cond
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc, %for.body
  %j.0 = phi i32 [ 1, %for.body ], [ %inc, %for.inc ]
  %cmp2 = icmp sle i32 %j.0, 40
  br i1 %cmp2, label %for.body3, label %for.end

for.body3:                                        ; preds = %for.cond1
  %idxprom = sext i32 %i.0 to i64
  %arrayidx = getelementptr inbounds [41 x [41 x double]], [41 x [41 x double]]* @rmr, i64 0, i64 %idxprom
  %idxprom4 = sext i32 %j.0 to i64
  %arrayidx5 = getelementptr inbounds [41 x double], [41 x double]* %arrayidx, i64 0, i64 %idxprom4
  call void @rInnerproduct(double* %arrayidx5, [41 x double]* getelementptr inbounds ([41 x [41 x double]], [41 x [41 x double]]* @rma, i32 0, i32 0), [41 x double]* getelementptr inbounds ([41 x [41 x double]], [41 x [41 x double]]* @rmb, i32 0, i32 0), i32 %i.0, i32 %j.0)
  br label %for.inc

for.inc:                                          ; preds = %for.body3
  %inc = add nsw i32 %j.0, 1
  br label %for.cond1

for.end:                                          ; preds = %for.cond1
  br label %for.inc6

for.inc6:                                         ; preds = %for.end
  %inc7 = add nsw i32 %i.0, 1
  br label %for.cond

for.end8:                                         ; preds = %for.cond
  %add = add nsw i32 %run, 1
  %idxprom9 = sext i32 %add to i64
  %arrayidx10 = getelementptr inbounds [41 x [41 x double]], [41 x [41 x double]]* @rmr, i64 0, i64 %idxprom9
  %add11 = add nsw i32 %run, 1
  %idxprom12 = sext i32 %add11 to i64
  %arrayidx13 = getelementptr inbounds [41 x double], [41 x double]* %arrayidx10, i64 0, i64 %idxprom12
  %0 = load double, double* %arrayidx13, align 8
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i32 0, i32 0), double %0)
  ret void
}

declare i32 @printf(i8*, ...) #1

; Function Attrs: noinline nounwind ssp uwtable
define i32 @main() #0 {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %for.inc ]
  %cmp = icmp slt i32 %i.0, 10
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  call void @Mm(i32 %i.0)
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %inc = add nsw i32 %i.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  ret i32 0
}

attributes #0 = { noinline nounwind ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{!"clang version 8.0.0 (tags/RELEASE_800/final 358332) (llvm/tags/RELEASE_800/final 358331)"}
