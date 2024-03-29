; ModuleID = '<stdin>'
source_filename = "/Users/angelicamoreira/UFMG/StaticAnalysis/TP1/CfgGenerator/src/TestFiles/stanford/Oscar/Oscar.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.14.0"

%struct.complex = type { float, float }
%struct.node = type { %struct.node*, %struct.node*, i32 }
%struct.element = type { i32, i32 }

@seed = common global i64 0, align 8
@.str = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.1 = private unnamed_addr constant [15 x i8] c"  %15.3f%15.3f\00", align 1
@e = common global [130 x %struct.complex] zeroinitializer, align 16
@zr = common global float 0.000000e+00, align 4
@zi = common global float 0.000000e+00, align 4
@z = common global [257 x %struct.complex] zeroinitializer, align 16
@w = common global [257 x %struct.complex] zeroinitializer, align 16
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
define float @Cos(float %x) #0 {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %result.0 = phi float [ 1.000000e+00, %entry ], [ %result.2, %for.inc ]
  %factor.0 = phi i32 [ 1, %entry ], [ %mul, %for.inc ]
  %i.0 = phi i32 [ 2, %entry ], [ %inc, %for.inc ]
  %power.0 = phi float [ %x, %entry ], [ %mul1, %for.inc ]
  %cmp = icmp sle i32 %i.0, 10
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %mul = mul nsw i32 %factor.0, %i.0
  %mul1 = fmul float %power.0, %x
  %and = and i32 %i.0, 1
  %cmp2 = icmp eq i32 %and, 0
  br i1 %cmp2, label %if.then, label %if.end8

if.then:                                          ; preds = %for.body
  %and3 = and i32 %i.0, 3
  %cmp4 = icmp eq i32 %and3, 0
  br i1 %cmp4, label %if.then5, label %if.else

if.then5:                                         ; preds = %if.then
  %conv = sitofp i32 %mul to float
  %div = fdiv float %mul1, %conv
  %add = fadd float %result.0, %div
  br label %if.end

if.else:                                          ; preds = %if.then
  %conv6 = sitofp i32 %mul to float
  %div7 = fdiv float %mul1, %conv6
  %sub = fsub float %result.0, %div7
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then5
  %result.1 = phi float [ %add, %if.then5 ], [ %sub, %if.else ]
  br label %if.end8

if.end8:                                          ; preds = %if.end, %for.body
  %result.2 = phi float [ %result.1, %if.end ], [ %result.0, %for.body ]
  br label %for.inc

for.inc:                                          ; preds = %if.end8
  %inc = add nsw i32 %i.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  ret float %result.0
}

; Function Attrs: noinline nounwind ssp uwtable
define i32 @Min0(i32 %arg1, i32 %arg2) #0 {
entry:
  %cmp = icmp slt i32 %arg1, %arg2
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  br label %return

if.else:                                          ; preds = %entry
  br label %return

return:                                           ; preds = %if.else, %if.then
  %retval.0 = phi i32 [ %arg1, %if.then ], [ %arg2, %if.else ]
  ret i32 %retval.0
}

; Function Attrs: noinline nounwind ssp uwtable
define void @Printcomplex(%struct.complex* %zarray, i32 %start, i32 %finish, i32 %increment) #0 {
entry:
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i32 0, i32 0))
  br label %do.body

do.body:                                          ; preds = %do.cond, %entry
  %i.0 = phi i32 [ %start, %entry ], [ %add15, %do.cond ]
  %idxprom = sext i32 %i.0 to i64
  %arrayidx = getelementptr inbounds %struct.complex, %struct.complex* %zarray, i64 %idxprom
  %rp = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx, i32 0, i32 0
  %0 = load float, float* %rp, align 4
  %conv = fpext float %0 to double
  %idxprom1 = sext i32 %i.0 to i64
  %arrayidx2 = getelementptr inbounds %struct.complex, %struct.complex* %zarray, i64 %idxprom1
  %ip = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx2, i32 0, i32 1
  %1 = load float, float* %ip, align 4
  %conv3 = fpext float %1 to double
  %call4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.1, i32 0, i32 0), double %conv, double %conv3)
  %add = add nsw i32 %i.0, %increment
  %idxprom5 = sext i32 %add to i64
  %arrayidx6 = getelementptr inbounds %struct.complex, %struct.complex* %zarray, i64 %idxprom5
  %rp7 = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx6, i32 0, i32 0
  %2 = load float, float* %rp7, align 4
  %conv8 = fpext float %2 to double
  %idxprom9 = sext i32 %add to i64
  %arrayidx10 = getelementptr inbounds %struct.complex, %struct.complex* %zarray, i64 %idxprom9
  %ip11 = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx10, i32 0, i32 1
  %3 = load float, float* %ip11, align 4
  %conv12 = fpext float %3 to double
  %call13 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.1, i32 0, i32 0), double %conv8, double %conv12)
  %call14 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i32 0, i32 0))
  %add15 = add nsw i32 %add, %increment
  br label %do.cond

do.cond:                                          ; preds = %do.body
  %cmp = icmp sle i32 %add15, %finish
  br i1 %cmp, label %do.body, label %do.end

do.end:                                           ; preds = %do.cond
  ret void
}

declare i32 @printf(i8*, ...) #1

; Function Attrs: noinline nounwind ssp uwtable
define void @Uniform11(i32* %iy, float* %yfl) #0 {
entry:
  %0 = load i32, i32* %iy, align 4
  %mul = mul nsw i32 4855, %0
  %add = add nsw i32 %mul, 1731
  %and = and i32 %add, 8191
  store i32 %and, i32* %iy, align 4
  %1 = load i32, i32* %iy, align 4
  %conv = sitofp i32 %1 to float
  %div = fdiv float %conv, 8.192000e+03
  store float %div, float* %yfl, align 4
  ret void
}

; Function Attrs: noinline nounwind ssp uwtable
define void @Exptab(i32 %n, %struct.complex* %e) #0 {
entry:
  %h = alloca [26 x float], align 16
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i32 [ 1, %entry ], [ %inc, %for.inc ]
  %divisor.0 = phi float [ 4.000000e+00, %entry ], [ %add, %for.inc ]
  %cmp = icmp sle i32 %i.0, 25
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %div = fdiv float 0x400921FB60000000, %divisor.0
  %call = call float @Cos(float %div)
  %mul = fmul float 2.000000e+00, %call
  %div1 = fdiv float 1.000000e+00, %mul
  %idxprom = sext i32 %i.0 to i64
  %arrayidx = getelementptr inbounds [26 x float], [26 x float]* %h, i64 0, i64 %idxprom
  store float %div1, float* %arrayidx, align 4
  %add = fadd float %divisor.0, %divisor.0
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %inc = add nsw i32 %i.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %div2 = sdiv i32 %n, 2
  %div3 = sdiv i32 %div2, 2
  %arrayidx4 = getelementptr inbounds %struct.complex, %struct.complex* %e, i64 1
  %rp = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx4, i32 0, i32 0
  store float 1.000000e+00, float* %rp, align 4
  %arrayidx5 = getelementptr inbounds %struct.complex, %struct.complex* %e, i64 1
  %ip = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx5, i32 0, i32 1
  store float 0.000000e+00, float* %ip, align 4
  %add6 = add nsw i32 %div3, 1
  %idxprom7 = sext i32 %add6 to i64
  %arrayidx8 = getelementptr inbounds %struct.complex, %struct.complex* %e, i64 %idxprom7
  %rp9 = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx8, i32 0, i32 0
  store float 0.000000e+00, float* %rp9, align 4
  %add10 = add nsw i32 %div3, 1
  %idxprom11 = sext i32 %add10 to i64
  %arrayidx12 = getelementptr inbounds %struct.complex, %struct.complex* %e, i64 %idxprom11
  %ip13 = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx12, i32 0, i32 1
  store float 1.000000e+00, float* %ip13, align 4
  %add14 = add nsw i32 %div2, 1
  %idxprom15 = sext i32 %add14 to i64
  %arrayidx16 = getelementptr inbounds %struct.complex, %struct.complex* %e, i64 %idxprom15
  %rp17 = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx16, i32 0, i32 0
  store float -1.000000e+00, float* %rp17, align 4
  %add18 = add nsw i32 %div2, 1
  %idxprom19 = sext i32 %add18 to i64
  %arrayidx20 = getelementptr inbounds %struct.complex, %struct.complex* %e, i64 %idxprom19
  %ip21 = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx20, i32 0, i32 1
  store float 0.000000e+00, float* %ip21, align 4
  br label %do.body

do.body:                                          ; preds = %do.cond63, %for.end
  %j.0 = phi i32 [ 1, %for.end ], [ %call62, %do.cond63 ]
  %l.0 = phi i32 [ %div3, %for.end ], [ %div22, %do.cond63 ]
  %div22 = sdiv i32 %l.0, 2
  br label %do.body23

do.body23:                                        ; preds = %do.cond, %do.body
  %k.0 = phi i32 [ %div22, %do.body ], [ %add59, %do.cond ]
  %idxprom24 = sext i32 %j.0 to i64
  %arrayidx25 = getelementptr inbounds [26 x float], [26 x float]* %h, i64 0, i64 %idxprom24
  %0 = load float, float* %arrayidx25, align 4
  %add26 = add nsw i32 %k.0, %div22
  %add27 = add nsw i32 %add26, 1
  %idxprom28 = sext i32 %add27 to i64
  %arrayidx29 = getelementptr inbounds %struct.complex, %struct.complex* %e, i64 %idxprom28
  %rp30 = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx29, i32 0, i32 0
  %1 = load float, float* %rp30, align 4
  %sub = sub nsw i32 %k.0, %div22
  %add31 = add nsw i32 %sub, 1
  %idxprom32 = sext i32 %add31 to i64
  %arrayidx33 = getelementptr inbounds %struct.complex, %struct.complex* %e, i64 %idxprom32
  %rp34 = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx33, i32 0, i32 0
  %2 = load float, float* %rp34, align 4
  %add35 = fadd float %1, %2
  %mul36 = fmul float %0, %add35
  %add37 = add nsw i32 %k.0, 1
  %idxprom38 = sext i32 %add37 to i64
  %arrayidx39 = getelementptr inbounds %struct.complex, %struct.complex* %e, i64 %idxprom38
  %rp40 = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx39, i32 0, i32 0
  store float %mul36, float* %rp40, align 4
  %idxprom41 = sext i32 %j.0 to i64
  %arrayidx42 = getelementptr inbounds [26 x float], [26 x float]* %h, i64 0, i64 %idxprom41
  %3 = load float, float* %arrayidx42, align 4
  %add43 = add nsw i32 %k.0, %div22
  %add44 = add nsw i32 %add43, 1
  %idxprom45 = sext i32 %add44 to i64
  %arrayidx46 = getelementptr inbounds %struct.complex, %struct.complex* %e, i64 %idxprom45
  %ip47 = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx46, i32 0, i32 1
  %4 = load float, float* %ip47, align 4
  %sub48 = sub nsw i32 %k.0, %div22
  %add49 = add nsw i32 %sub48, 1
  %idxprom50 = sext i32 %add49 to i64
  %arrayidx51 = getelementptr inbounds %struct.complex, %struct.complex* %e, i64 %idxprom50
  %ip52 = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx51, i32 0, i32 1
  %5 = load float, float* %ip52, align 4
  %add53 = fadd float %4, %5
  %mul54 = fmul float %3, %add53
  %add55 = add nsw i32 %k.0, 1
  %idxprom56 = sext i32 %add55 to i64
  %arrayidx57 = getelementptr inbounds %struct.complex, %struct.complex* %e, i64 %idxprom56
  %ip58 = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx57, i32 0, i32 1
  store float %mul54, float* %ip58, align 4
  %add59 = add nsw i32 %k.0, %l.0
  br label %do.cond

do.cond:                                          ; preds = %do.body23
  %cmp60 = icmp sle i32 %add59, %div2
  br i1 %cmp60, label %do.body23, label %do.end

do.end:                                           ; preds = %do.cond
  %add61 = add nsw i32 %j.0, 1
  %call62 = call i32 @Min0(i32 %add61, i32 25)
  br label %do.cond63

do.cond63:                                        ; preds = %do.end
  %cmp64 = icmp sgt i32 %div22, 1
  br i1 %cmp64, label %do.body, label %do.end65

do.end65:                                         ; preds = %do.cond63
  ret void
}

; Function Attrs: noinline nounwind ssp uwtable
define void @Fft(i32 %n, %struct.complex* %z, %struct.complex* %w, %struct.complex* %e, float %sqrinv) #0 {
entry:
  %div = sdiv i32 %n, 2
  br label %do.body

do.body:                                          ; preds = %do.cond97, %entry
  %l.0 = phi i32 [ 1, %entry ], [ %add96, %do.cond97 ]
  br label %do.body1

do.body1:                                         ; preds = %do.cond84, %do.body
  %i.0 = phi i32 [ 1, %do.body ], [ %add82, %do.cond84 ]
  %j.0 = phi i32 [ %l.0, %do.body ], [ %add83, %do.cond84 ]
  %k.0 = phi i32 [ 0, %do.body ], [ %j.0, %do.cond84 ]
  br label %do.body2

do.body2:                                         ; preds = %do.cond, %do.body1
  %i.1 = phi i32 [ %i.0, %do.body1 ], [ %add82, %do.cond ]
  %idxprom = sext i32 %i.1 to i64
  %arrayidx = getelementptr inbounds %struct.complex, %struct.complex* %z, i64 %idxprom
  %rp = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx, i32 0, i32 0
  %0 = load float, float* %rp, align 4
  %add = add nsw i32 %div, %i.1
  %idxprom3 = sext i32 %add to i64
  %arrayidx4 = getelementptr inbounds %struct.complex, %struct.complex* %z, i64 %idxprom3
  %rp5 = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx4, i32 0, i32 0
  %1 = load float, float* %rp5, align 4
  %add6 = fadd float %0, %1
  %add7 = add nsw i32 %i.1, %k.0
  %idxprom8 = sext i32 %add7 to i64
  %arrayidx9 = getelementptr inbounds %struct.complex, %struct.complex* %w, i64 %idxprom8
  %rp10 = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx9, i32 0, i32 0
  store float %add6, float* %rp10, align 4
  %idxprom11 = sext i32 %i.1 to i64
  %arrayidx12 = getelementptr inbounds %struct.complex, %struct.complex* %z, i64 %idxprom11
  %ip = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx12, i32 0, i32 1
  %2 = load float, float* %ip, align 4
  %add13 = add nsw i32 %div, %i.1
  %idxprom14 = sext i32 %add13 to i64
  %arrayidx15 = getelementptr inbounds %struct.complex, %struct.complex* %z, i64 %idxprom14
  %ip16 = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx15, i32 0, i32 1
  %3 = load float, float* %ip16, align 4
  %add17 = fadd float %2, %3
  %add18 = add nsw i32 %i.1, %k.0
  %idxprom19 = sext i32 %add18 to i64
  %arrayidx20 = getelementptr inbounds %struct.complex, %struct.complex* %w, i64 %idxprom19
  %ip21 = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx20, i32 0, i32 1
  store float %add17, float* %ip21, align 4
  %add22 = add nsw i32 %k.0, 1
  %idxprom23 = sext i32 %add22 to i64
  %arrayidx24 = getelementptr inbounds %struct.complex, %struct.complex* %e, i64 %idxprom23
  %rp25 = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx24, i32 0, i32 0
  %4 = load float, float* %rp25, align 4
  %idxprom26 = sext i32 %i.1 to i64
  %arrayidx27 = getelementptr inbounds %struct.complex, %struct.complex* %z, i64 %idxprom26
  %rp28 = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx27, i32 0, i32 0
  %5 = load float, float* %rp28, align 4
  %add29 = add nsw i32 %i.1, %div
  %idxprom30 = sext i32 %add29 to i64
  %arrayidx31 = getelementptr inbounds %struct.complex, %struct.complex* %z, i64 %idxprom30
  %rp32 = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx31, i32 0, i32 0
  %6 = load float, float* %rp32, align 4
  %sub = fsub float %5, %6
  %mul = fmul float %4, %sub
  %add33 = add nsw i32 %k.0, 1
  %idxprom34 = sext i32 %add33 to i64
  %arrayidx35 = getelementptr inbounds %struct.complex, %struct.complex* %e, i64 %idxprom34
  %ip36 = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx35, i32 0, i32 1
  %7 = load float, float* %ip36, align 4
  %idxprom37 = sext i32 %i.1 to i64
  %arrayidx38 = getelementptr inbounds %struct.complex, %struct.complex* %z, i64 %idxprom37
  %ip39 = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx38, i32 0, i32 1
  %8 = load float, float* %ip39, align 4
  %add40 = add nsw i32 %i.1, %div
  %idxprom41 = sext i32 %add40 to i64
  %arrayidx42 = getelementptr inbounds %struct.complex, %struct.complex* %z, i64 %idxprom41
  %ip43 = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx42, i32 0, i32 1
  %9 = load float, float* %ip43, align 4
  %sub44 = fsub float %8, %9
  %mul45 = fmul float %7, %sub44
  %sub46 = fsub float %mul, %mul45
  %add47 = add nsw i32 %i.1, %j.0
  %idxprom48 = sext i32 %add47 to i64
  %arrayidx49 = getelementptr inbounds %struct.complex, %struct.complex* %w, i64 %idxprom48
  %rp50 = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx49, i32 0, i32 0
  store float %sub46, float* %rp50, align 4
  %add51 = add nsw i32 %k.0, 1
  %idxprom52 = sext i32 %add51 to i64
  %arrayidx53 = getelementptr inbounds %struct.complex, %struct.complex* %e, i64 %idxprom52
  %rp54 = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx53, i32 0, i32 0
  %10 = load float, float* %rp54, align 4
  %idxprom55 = sext i32 %i.1 to i64
  %arrayidx56 = getelementptr inbounds %struct.complex, %struct.complex* %z, i64 %idxprom55
  %ip57 = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx56, i32 0, i32 1
  %11 = load float, float* %ip57, align 4
  %add58 = add nsw i32 %i.1, %div
  %idxprom59 = sext i32 %add58 to i64
  %arrayidx60 = getelementptr inbounds %struct.complex, %struct.complex* %z, i64 %idxprom59
  %ip61 = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx60, i32 0, i32 1
  %12 = load float, float* %ip61, align 4
  %sub62 = fsub float %11, %12
  %mul63 = fmul float %10, %sub62
  %add64 = add nsw i32 %k.0, 1
  %idxprom65 = sext i32 %add64 to i64
  %arrayidx66 = getelementptr inbounds %struct.complex, %struct.complex* %e, i64 %idxprom65
  %ip67 = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx66, i32 0, i32 1
  %13 = load float, float* %ip67, align 4
  %idxprom68 = sext i32 %i.1 to i64
  %arrayidx69 = getelementptr inbounds %struct.complex, %struct.complex* %z, i64 %idxprom68
  %rp70 = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx69, i32 0, i32 0
  %14 = load float, float* %rp70, align 4
  %add71 = add nsw i32 %i.1, %div
  %idxprom72 = sext i32 %add71 to i64
  %arrayidx73 = getelementptr inbounds %struct.complex, %struct.complex* %z, i64 %idxprom72
  %rp74 = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx73, i32 0, i32 0
  %15 = load float, float* %rp74, align 4
  %sub75 = fsub float %14, %15
  %mul76 = fmul float %13, %sub75
  %add77 = fadd float %mul63, %mul76
  %add78 = add nsw i32 %i.1, %j.0
  %idxprom79 = sext i32 %add78 to i64
  %arrayidx80 = getelementptr inbounds %struct.complex, %struct.complex* %w, i64 %idxprom79
  %ip81 = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx80, i32 0, i32 1
  store float %add77, float* %ip81, align 4
  %add82 = add nsw i32 %i.1, 1
  br label %do.cond

do.cond:                                          ; preds = %do.body2
  %cmp = icmp sle i32 %add82, %j.0
  br i1 %cmp, label %do.body2, label %do.end

do.end:                                           ; preds = %do.cond
  %add83 = add nsw i32 %j.0, %l.0
  br label %do.cond84

do.cond84:                                        ; preds = %do.end
  %cmp85 = icmp sle i32 %add83, %div
  br i1 %cmp85, label %do.body1, label %do.end86

do.end86:                                         ; preds = %do.cond84
  br label %do.body87

do.body87:                                        ; preds = %do.cond93, %do.end86
  %index.0 = phi i32 [ 1, %do.end86 ], [ %add92, %do.cond93 ]
  %idxprom88 = sext i32 %index.0 to i64
  %arrayidx89 = getelementptr inbounds %struct.complex, %struct.complex* %z, i64 %idxprom88
  %idxprom90 = sext i32 %index.0 to i64
  %arrayidx91 = getelementptr inbounds %struct.complex, %struct.complex* %w, i64 %idxprom90
  %16 = bitcast %struct.complex* %arrayidx89 to i8*
  %17 = bitcast %struct.complex* %arrayidx91 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %16, i8* align 4 %17, i64 8, i1 false)
  %add92 = add nsw i32 %index.0, 1
  br label %do.cond93

do.cond93:                                        ; preds = %do.body87
  %cmp94 = icmp sle i32 %add92, %n
  br i1 %cmp94, label %do.body87, label %do.end95

do.end95:                                         ; preds = %do.cond93
  %add96 = add nsw i32 %l.0, %l.0
  br label %do.cond97

do.cond97:                                        ; preds = %do.end95
  %cmp98 = icmp sle i32 %add96, %div
  br i1 %cmp98, label %do.body, label %do.end99

do.end99:                                         ; preds = %do.cond97
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %do.end99
  %i.2 = phi i32 [ 1, %do.end99 ], [ %inc, %for.inc ]
  %cmp100 = icmp sle i32 %i.2, %n
  br i1 %cmp100, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %idxprom101 = sext i32 %i.2 to i64
  %arrayidx102 = getelementptr inbounds %struct.complex, %struct.complex* %z, i64 %idxprom101
  %rp103 = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx102, i32 0, i32 0
  %18 = load float, float* %rp103, align 4
  %mul104 = fmul float %sqrinv, %18
  %idxprom105 = sext i32 %i.2 to i64
  %arrayidx106 = getelementptr inbounds %struct.complex, %struct.complex* %z, i64 %idxprom105
  %rp107 = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx106, i32 0, i32 0
  store float %mul104, float* %rp107, align 4
  %sub108 = fsub float -0.000000e+00, %sqrinv
  %idxprom109 = sext i32 %i.2 to i64
  %arrayidx110 = getelementptr inbounds %struct.complex, %struct.complex* %z, i64 %idxprom109
  %ip111 = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx110, i32 0, i32 1
  %19 = load float, float* %ip111, align 4
  %mul112 = fmul float %sub108, %19
  %idxprom113 = sext i32 %i.2 to i64
  %arrayidx114 = getelementptr inbounds %struct.complex, %struct.complex* %z, i64 %idxprom113
  %ip115 = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx114, i32 0, i32 1
  store float %mul112, float* %ip115, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %inc = add nsw i32 %i.2, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i1) #2

; Function Attrs: noinline nounwind ssp uwtable
define void @Oscar() #0 {
entry:
  %s = alloca i32, align 4
  call void @Exptab(i32 256, %struct.complex* getelementptr inbounds ([130 x %struct.complex], [130 x %struct.complex]* @e, i32 0, i32 0))
  store i64 5767, i64* @seed, align 8
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i32 [ 1, %entry ], [ %inc, %for.inc ]
  %cmp = icmp sle i32 %i.0, 256
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %0 = load i64, i64* @seed, align 8
  %conv = trunc i64 %0 to i32
  store i32 %conv, i32* %s, align 4
  call void @Uniform11(i32* %s, float* @zr)
  %1 = load i32, i32* %s, align 4
  %conv1 = sext i32 %1 to i64
  store i64 %conv1, i64* @seed, align 8
  call void @Uniform11(i32* %s, float* @zi)
  %2 = load i32, i32* %s, align 4
  %conv2 = sext i32 %2 to i64
  store i64 %conv2, i64* @seed, align 8
  %3 = load float, float* @zr, align 4
  %mul = fmul float 2.000000e+01, %3
  %sub = fsub float %mul, 1.000000e+01
  %idxprom = sext i32 %i.0 to i64
  %arrayidx = getelementptr inbounds [257 x %struct.complex], [257 x %struct.complex]* @z, i64 0, i64 %idxprom
  %rp = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx, i32 0, i32 0
  store float %sub, float* %rp, align 8
  %4 = load float, float* @zi, align 4
  %mul3 = fmul float 2.000000e+01, %4
  %sub4 = fsub float %mul3, 1.000000e+01
  %idxprom5 = sext i32 %i.0 to i64
  %arrayidx6 = getelementptr inbounds [257 x %struct.complex], [257 x %struct.complex]* @z, i64 0, i64 %idxprom5
  %ip = getelementptr inbounds %struct.complex, %struct.complex* %arrayidx6, i32 0, i32 1
  store float %sub4, float* %ip, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %inc = add nsw i32 %i.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  br label %for.cond7

for.cond7:                                        ; preds = %for.inc11, %for.end
  %i.1 = phi i32 [ 1, %for.end ], [ %inc12, %for.inc11 ]
  %cmp8 = icmp sle i32 %i.1, 20
  br i1 %cmp8, label %for.body10, label %for.end13

for.body10:                                       ; preds = %for.cond7
  call void @Fft(i32 256, %struct.complex* getelementptr inbounds ([257 x %struct.complex], [257 x %struct.complex]* @z, i32 0, i32 0), %struct.complex* getelementptr inbounds ([257 x %struct.complex], [257 x %struct.complex]* @w, i32 0, i32 0), %struct.complex* getelementptr inbounds ([130 x %struct.complex], [130 x %struct.complex]* @e, i32 0, i32 0), float 6.250000e-02)
  br label %for.inc11

for.inc11:                                        ; preds = %for.body10
  %inc12 = add nsw i32 %i.1, 1
  br label %for.cond7

for.end13:                                        ; preds = %for.cond7
  call void @Printcomplex(%struct.complex* getelementptr inbounds ([257 x %struct.complex], [257 x %struct.complex]* @z, i32 0, i32 0), i32 1, i32 256, i32 17)
  ret void
}

; Function Attrs: noinline nounwind ssp uwtable
define i32 @main() #0 {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %for.inc ]
  %cmp = icmp slt i32 %i.0, 10
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  call void @Oscar()
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %inc = add nsw i32 %i.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  ret i32 0
}

attributes #0 = { noinline nounwind ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { argmemonly nounwind }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{!"clang version 8.0.0 (tags/RELEASE_800/final 358332) (llvm/tags/RELEASE_800/final 358331)"}
