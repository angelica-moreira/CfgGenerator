; ModuleID = '<stdin>'
source_filename = "/Users/angelicamoreira/UFMG/StaticAnalysis/TP1/CfgGenerator/src/TestFiles/stanford/Queens/Queens.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.14.0"

%struct.node = type { %struct.node*, %struct.node*, i32 }
%struct.element = type { i32, i32 }
%struct.complex = type { float, float }

@seed = common global i64 0, align 8
@.str = private unnamed_addr constant [19 x i8] c" Error in Queens.\0A\00", align 1
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
@sortlist = common global [5001 x i32] zeroinitializer, align 16
@biggest = common global i32 0, align 4
@littlest = common global i32 0, align 4
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
define void @Try(i32 %i, i32* %q, i32* %a, i32* %b, i32* %c, i32* %x) #0 {
entry:
  store i32 0, i32* %q, align 4
  br label %while.cond

while.cond:                                       ; preds = %if.end37, %entry
  %j.0 = phi i32 [ 0, %entry ], [ %add, %if.end37 ]
  %0 = load i32, i32* %q, align 4
  %tobool = icmp ne i32 %0, 0
  br i1 %tobool, label %land.end, label %land.rhs

land.rhs:                                         ; preds = %while.cond
  %cmp = icmp ne i32 %j.0, 8
  br label %land.end

land.end:                                         ; preds = %land.rhs, %while.cond
  %1 = phi i1 [ false, %while.cond ], [ %cmp, %land.rhs ]
  br i1 %1, label %while.body, label %while.end

while.body:                                       ; preds = %land.end
  %add = add nsw i32 %j.0, 1
  store i32 0, i32* %q, align 4
  %idxprom = sext i32 %add to i64
  %arrayidx = getelementptr inbounds i32, i32* %b, i64 %idxprom
  %2 = load i32, i32* %arrayidx, align 4
  %tobool1 = icmp ne i32 %2, 0
  br i1 %tobool1, label %land.lhs.true, label %if.end37

land.lhs.true:                                    ; preds = %while.body
  %add2 = add nsw i32 %i, %add
  %idxprom3 = sext i32 %add2 to i64
  %arrayidx4 = getelementptr inbounds i32, i32* %a, i64 %idxprom3
  %3 = load i32, i32* %arrayidx4, align 4
  %tobool5 = icmp ne i32 %3, 0
  br i1 %tobool5, label %land.lhs.true6, label %if.end37

land.lhs.true6:                                   ; preds = %land.lhs.true
  %sub = sub nsw i32 %i, %add
  %add7 = add nsw i32 %sub, 7
  %idxprom8 = sext i32 %add7 to i64
  %arrayidx9 = getelementptr inbounds i32, i32* %c, i64 %idxprom8
  %4 = load i32, i32* %arrayidx9, align 4
  %tobool10 = icmp ne i32 %4, 0
  br i1 %tobool10, label %if.then, label %if.end37

if.then:                                          ; preds = %land.lhs.true6
  %idxprom11 = sext i32 %i to i64
  %arrayidx12 = getelementptr inbounds i32, i32* %x, i64 %idxprom11
  store i32 %add, i32* %arrayidx12, align 4
  %idxprom13 = sext i32 %add to i64
  %arrayidx14 = getelementptr inbounds i32, i32* %b, i64 %idxprom13
  store i32 0, i32* %arrayidx14, align 4
  %add15 = add nsw i32 %i, %add
  %idxprom16 = sext i32 %add15 to i64
  %arrayidx17 = getelementptr inbounds i32, i32* %a, i64 %idxprom16
  store i32 0, i32* %arrayidx17, align 4
  %sub18 = sub nsw i32 %i, %add
  %add19 = add nsw i32 %sub18, 7
  %idxprom20 = sext i32 %add19 to i64
  %arrayidx21 = getelementptr inbounds i32, i32* %c, i64 %idxprom20
  store i32 0, i32* %arrayidx21, align 4
  %cmp22 = icmp slt i32 %i, 8
  br i1 %cmp22, label %if.then23, label %if.else

if.then23:                                        ; preds = %if.then
  %add24 = add nsw i32 %i, 1
  call void @Try(i32 %add24, i32* %q, i32* %a, i32* %b, i32* %c, i32* %x)
  %5 = load i32, i32* %q, align 4
  %tobool25 = icmp ne i32 %5, 0
  br i1 %tobool25, label %if.end, label %if.then26

if.then26:                                        ; preds = %if.then23
  %idxprom27 = sext i32 %add to i64
  %arrayidx28 = getelementptr inbounds i32, i32* %b, i64 %idxprom27
  store i32 1, i32* %arrayidx28, align 4
  %add29 = add nsw i32 %i, %add
  %idxprom30 = sext i32 %add29 to i64
  %arrayidx31 = getelementptr inbounds i32, i32* %a, i64 %idxprom30
  store i32 1, i32* %arrayidx31, align 4
  %sub32 = sub nsw i32 %i, %add
  %add33 = add nsw i32 %sub32, 7
  %idxprom34 = sext i32 %add33 to i64
  %arrayidx35 = getelementptr inbounds i32, i32* %c, i64 %idxprom34
  store i32 1, i32* %arrayidx35, align 4
  br label %if.end

if.end:                                           ; preds = %if.then26, %if.then23
  br label %if.end36

if.else:                                          ; preds = %if.then
  store i32 1, i32* %q, align 4
  br label %if.end36

if.end36:                                         ; preds = %if.else, %if.end
  br label %if.end37

if.end37:                                         ; preds = %if.end36, %land.lhs.true6, %land.lhs.true, %while.body
  br label %while.cond

while.end:                                        ; preds = %land.end
  ret void
}

; Function Attrs: noinline nounwind ssp uwtable
define void @Doit() #0 {
entry:
  %q = alloca i32, align 4
  %a = alloca [9 x i32], align 16
  %b = alloca [17 x i32], align 16
  %c = alloca [15 x i32], align 16
  %x = alloca [9 x i32], align 16
  br label %while.cond

while.cond:                                       ; preds = %if.end12, %entry
  %i.0 = phi i32 [ -7, %entry ], [ %add13, %if.end12 ]
  %cmp = icmp sle i32 %i.0, 16
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %cmp1 = icmp sge i32 %i.0, 1
  br i1 %cmp1, label %land.lhs.true, label %if.end

land.lhs.true:                                    ; preds = %while.body
  %cmp2 = icmp sle i32 %i.0, 8
  br i1 %cmp2, label %if.then, label %if.end

if.then:                                          ; preds = %land.lhs.true
  %idxprom = sext i32 %i.0 to i64
  %arrayidx = getelementptr inbounds [9 x i32], [9 x i32]* %a, i64 0, i64 %idxprom
  store i32 1, i32* %arrayidx, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %land.lhs.true, %while.body
  %cmp3 = icmp sge i32 %i.0, 2
  br i1 %cmp3, label %if.then4, label %if.end7

if.then4:                                         ; preds = %if.end
  %idxprom5 = sext i32 %i.0 to i64
  %arrayidx6 = getelementptr inbounds [17 x i32], [17 x i32]* %b, i64 0, i64 %idxprom5
  store i32 1, i32* %arrayidx6, align 4
  br label %if.end7

if.end7:                                          ; preds = %if.then4, %if.end
  %cmp8 = icmp sle i32 %i.0, 7
  br i1 %cmp8, label %if.then9, label %if.end12

if.then9:                                         ; preds = %if.end7
  %add = add nsw i32 %i.0, 7
  %idxprom10 = sext i32 %add to i64
  %arrayidx11 = getelementptr inbounds [15 x i32], [15 x i32]* %c, i64 0, i64 %idxprom10
  store i32 1, i32* %arrayidx11, align 4
  br label %if.end12

if.end12:                                         ; preds = %if.then9, %if.end7
  %add13 = add nsw i32 %i.0, 1
  br label %while.cond

while.end:                                        ; preds = %while.cond
  %arraydecay = getelementptr inbounds [17 x i32], [17 x i32]* %b, i32 0, i32 0
  %arraydecay14 = getelementptr inbounds [9 x i32], [9 x i32]* %a, i32 0, i32 0
  %arraydecay15 = getelementptr inbounds [15 x i32], [15 x i32]* %c, i32 0, i32 0
  %arraydecay16 = getelementptr inbounds [9 x i32], [9 x i32]* %x, i32 0, i32 0
  call void @Try(i32 1, i32* %q, i32* %arraydecay, i32* %arraydecay14, i32* %arraydecay15, i32* %arraydecay16)
  %0 = load i32, i32* %q, align 4
  %tobool = icmp ne i32 %0, 0
  br i1 %tobool, label %if.end18, label %if.then17

if.then17:                                        ; preds = %while.end
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str, i32 0, i32 0))
  br label %if.end18

if.end18:                                         ; preds = %if.then17, %while.end
  ret void
}

declare i32 @printf(i8*, ...) #1

; Function Attrs: noinline nounwind ssp uwtable
define void @Queens(i32 %run) #0 {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i32 [ 1, %entry ], [ %inc, %for.inc ]
  %cmp = icmp sle i32 %i.0, 50
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  call void @Doit()
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %inc = add nsw i32 %i.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %add = add nsw i32 %run, 1
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i32 0, i32 0), i32 %add)
  ret void
}

; Function Attrs: noinline nounwind ssp uwtable
define i32 @main() #0 {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %for.inc ]
  %cmp = icmp slt i32 %i.0, 100
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  call void @Queens(i32 %i.0)
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
