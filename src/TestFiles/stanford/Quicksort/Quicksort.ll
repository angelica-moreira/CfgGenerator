; ModuleID = '<stdin>'
source_filename = "/Users/angelicamoreira/UFMG/StaticAnalysis/TP1/CfgGenerator/src/TestFiles/stanford/Quicksort/Quicksort.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.14.0"

%struct.node = type { %struct.node*, %struct.node*, i32 }
%struct.element = type { i32, i32 }
%struct.complex = type { float, float }

@seed = common global i64 0, align 8
@biggest = common global i32 0, align 4
@littlest = common global i32 0, align 4
@sortlist = common global [5001 x i32] zeroinitializer, align 16
@.str = private unnamed_addr constant [18 x i8] c" Error in Quick.\0A\00", align 1
@.str.1 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@value = common global float 0.000000e+00, align 4
@fixed = common global float 0.000000e+00, align 4
@floated = common global float 0.000000e+00, align 4
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
@rma = common global [41 x [41 x float]] zeroinitializer, align 16
@rmb = common global [41 x [41 x float]] zeroinitializer, align 16
@rmr = common global [41 x [41 x float]] zeroinitializer, align 16
@piececount = common global [4 x i32] zeroinitializer, align 16
@class = common global [13 x i32] zeroinitializer, align 16
@piecemax = common global [13 x i32] zeroinitializer, align 16
@puzzl = common global [512 x i32] zeroinitializer, align 16
@p = common global [13 x [512 x i32]] zeroinitializer, align 16
@n = common global i32 0, align 4
@kount = common global i32 0, align 4
@top = common global i32 0, align 4
@z = common global [257 x %struct.complex] zeroinitializer, align 16
@w = common global [257 x %struct.complex] zeroinitializer, align 16
@e = common global [130 x %struct.complex] zeroinitializer, align 16
@zr = common global float 0.000000e+00, align 4
@zi = common global float 0.000000e+00, align 4

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
define void @Initarr() #0 {
entry:
  call void @Initrand()
  store i32 0, i32* @biggest, align 4
  store i32 0, i32* @littlest, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i32 [ 1, %entry ], [ %inc, %for.inc ]
  %cmp = icmp sle i32 %i.0, 5000
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %call = call i32 @Rand()
  %conv = sext i32 %call to i64
  %div = sdiv i64 %conv, 100000
  %mul = mul nsw i64 %div, 100000
  %sub = sub nsw i64 %conv, %mul
  %sub1 = sub nsw i64 %sub, 50000
  %conv2 = trunc i64 %sub1 to i32
  %idxprom = sext i32 %i.0 to i64
  %arrayidx = getelementptr inbounds [5001 x i32], [5001 x i32]* @sortlist, i64 0, i64 %idxprom
  store i32 %conv2, i32* %arrayidx, align 4
  %idxprom3 = sext i32 %i.0 to i64
  %arrayidx4 = getelementptr inbounds [5001 x i32], [5001 x i32]* @sortlist, i64 0, i64 %idxprom3
  %0 = load i32, i32* %arrayidx4, align 4
  %1 = load i32, i32* @biggest, align 4
  %cmp5 = icmp sgt i32 %0, %1
  br i1 %cmp5, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %idxprom7 = sext i32 %i.0 to i64
  %arrayidx8 = getelementptr inbounds [5001 x i32], [5001 x i32]* @sortlist, i64 0, i64 %idxprom7
  %2 = load i32, i32* %arrayidx8, align 4
  store i32 %2, i32* @biggest, align 4
  br label %if.end16

if.else:                                          ; preds = %for.body
  %idxprom9 = sext i32 %i.0 to i64
  %arrayidx10 = getelementptr inbounds [5001 x i32], [5001 x i32]* @sortlist, i64 0, i64 %idxprom9
  %3 = load i32, i32* %arrayidx10, align 4
  %4 = load i32, i32* @littlest, align 4
  %cmp11 = icmp slt i32 %3, %4
  br i1 %cmp11, label %if.then13, label %if.end

if.then13:                                        ; preds = %if.else
  %idxprom14 = sext i32 %i.0 to i64
  %arrayidx15 = getelementptr inbounds [5001 x i32], [5001 x i32]* @sortlist, i64 0, i64 %idxprom14
  %5 = load i32, i32* %arrayidx15, align 4
  store i32 %5, i32* @littlest, align 4
  br label %if.end

if.end:                                           ; preds = %if.then13, %if.else
  br label %if.end16

if.end16:                                         ; preds = %if.end, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end16
  %inc = add nsw i32 %i.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  ret void
}

; Function Attrs: noinline nounwind ssp uwtable
define void @Quicksort(i32* %a, i32 %l, i32 %r) #0 {
entry:
  %add = add nsw i32 %l, %r
  %div = sdiv i32 %add, 2
  %idxprom = sext i32 %div to i64
  %arrayidx = getelementptr inbounds i32, i32* %a, i64 %idxprom
  %0 = load i32, i32* %arrayidx, align 4
  br label %do.body

do.body:                                          ; preds = %do.cond, %entry
  %i.0 = phi i32 [ %l, %entry ], [ %i.2, %do.cond ]
  %j.0 = phi i32 [ %r, %entry ], [ %j.2, %do.cond ]
  br label %while.cond

while.cond:                                       ; preds = %while.body, %do.body
  %i.1 = phi i32 [ %i.0, %do.body ], [ %add3, %while.body ]
  %idxprom1 = sext i32 %i.1 to i64
  %arrayidx2 = getelementptr inbounds i32, i32* %a, i64 %idxprom1
  %1 = load i32, i32* %arrayidx2, align 4
  %cmp = icmp slt i32 %1, %0
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %add3 = add nsw i32 %i.1, 1
  br label %while.cond

while.end:                                        ; preds = %while.cond
  br label %while.cond4

while.cond4:                                      ; preds = %while.body8, %while.end
  %j.1 = phi i32 [ %j.0, %while.end ], [ %sub, %while.body8 ]
  %idxprom5 = sext i32 %j.1 to i64
  %arrayidx6 = getelementptr inbounds i32, i32* %a, i64 %idxprom5
  %2 = load i32, i32* %arrayidx6, align 4
  %cmp7 = icmp slt i32 %0, %2
  br i1 %cmp7, label %while.body8, label %while.end9

while.body8:                                      ; preds = %while.cond4
  %sub = sub nsw i32 %j.1, 1
  br label %while.cond4

while.end9:                                       ; preds = %while.cond4
  %cmp10 = icmp sle i32 %i.1, %j.1
  br i1 %cmp10, label %if.then, label %if.end

if.then:                                          ; preds = %while.end9
  %idxprom11 = sext i32 %i.1 to i64
  %arrayidx12 = getelementptr inbounds i32, i32* %a, i64 %idxprom11
  %3 = load i32, i32* %arrayidx12, align 4
  %idxprom13 = sext i32 %j.1 to i64
  %arrayidx14 = getelementptr inbounds i32, i32* %a, i64 %idxprom13
  %4 = load i32, i32* %arrayidx14, align 4
  %idxprom15 = sext i32 %i.1 to i64
  %arrayidx16 = getelementptr inbounds i32, i32* %a, i64 %idxprom15
  store i32 %4, i32* %arrayidx16, align 4
  %idxprom17 = sext i32 %j.1 to i64
  %arrayidx18 = getelementptr inbounds i32, i32* %a, i64 %idxprom17
  store i32 %3, i32* %arrayidx18, align 4
  %add19 = add nsw i32 %i.1, 1
  %sub20 = sub nsw i32 %j.1, 1
  br label %if.end

if.end:                                           ; preds = %if.then, %while.end9
  %i.2 = phi i32 [ %add19, %if.then ], [ %i.1, %while.end9 ]
  %j.2 = phi i32 [ %sub20, %if.then ], [ %j.1, %while.end9 ]
  br label %do.cond

do.cond:                                          ; preds = %if.end
  %cmp21 = icmp sle i32 %i.2, %j.2
  br i1 %cmp21, label %do.body, label %do.end

do.end:                                           ; preds = %do.cond
  %cmp22 = icmp slt i32 %l, %j.2
  br i1 %cmp22, label %if.then23, label %if.end24

if.then23:                                        ; preds = %do.end
  call void @Quicksort(i32* %a, i32 %l, i32 %j.2)
  br label %if.end24

if.end24:                                         ; preds = %if.then23, %do.end
  %cmp25 = icmp slt i32 %i.2, %r
  br i1 %cmp25, label %if.then26, label %if.end27

if.then26:                                        ; preds = %if.end24
  call void @Quicksort(i32* %a, i32 %i.2, i32 %r)
  br label %if.end27

if.end27:                                         ; preds = %if.then26, %if.end24
  ret void
}

; Function Attrs: noinline nounwind ssp uwtable
define void @Quick(i32 %run) #0 {
entry:
  call void @Initarr()
  call void @Quicksort(i32* getelementptr inbounds ([5001 x i32], [5001 x i32]* @sortlist, i32 0, i32 0), i32 1, i32 5000)
  %0 = load i32, i32* getelementptr inbounds ([5001 x i32], [5001 x i32]* @sortlist, i64 0, i64 1), align 4
  %1 = load i32, i32* @littlest, align 4
  %cmp = icmp ne i32 %0, %1
  br i1 %cmp, label %if.then, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %entry
  %2 = load i32, i32* getelementptr inbounds ([5001 x i32], [5001 x i32]* @sortlist, i64 0, i64 5000), align 16
  %3 = load i32, i32* @biggest, align 4
  %cmp1 = icmp ne i32 %2, %3
  br i1 %cmp1, label %if.then, label %if.end

if.then:                                          ; preds = %lor.lhs.false, %entry
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str, i32 0, i32 0))
  br label %if.end

if.end:                                           ; preds = %if.then, %lor.lhs.false
  %add = add nsw i32 %run, 1
  %idxprom = sext i32 %add to i64
  %arrayidx = getelementptr inbounds [5001 x i32], [5001 x i32]* @sortlist, i64 0, i64 %idxprom
  %4 = load i32, i32* %arrayidx, align 4
  %call2 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i32 0, i32 0), i32 %4)
  ret void
}

declare i32 @printf(i8*, ...) #1

; Function Attrs: noinline nounwind ssp uwtable
define i32 @main() #0 {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %for.inc ]
  %cmp = icmp slt i32 %i.0, 100
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  call void @Quick(i32 %i.0)
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
