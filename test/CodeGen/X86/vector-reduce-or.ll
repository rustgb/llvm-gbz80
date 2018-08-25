; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse2 | FileCheck %s --check-prefix=ALL --check-prefix=SSE --check-prefix=SSE2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse4.1 | FileCheck %s --check-prefix=ALL --check-prefix=SSE --check-prefix=SSE41
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx | FileCheck %s --check-prefix=ALL --check-prefix=AVX --check-prefix=AVX1
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx2 | FileCheck %s --check-prefix=ALL --check-prefix=AVX --check-prefix=AVX2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512f,+avx512bw | FileCheck %s --check-prefix=ALL --check-prefix=AVX512 --check-prefix=AVX512BW
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512f,+avx512bw,+avx512vl | FileCheck %s --check-prefix=ALL --check-prefix=AVX512 --check-prefix=AVX512VL

;
; vXi64
;

define i64 @test_v2i64(<2 x i64> %a0) {
; SSE-LABEL: test_v2i64:
; SSE:       # %bb.0:
; SSE-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; SSE-NEXT:    por %xmm0, %xmm1
; SSE-NEXT:    movq %xmm1, %rax
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v2i64:
; AVX:       # %bb.0:
; AVX-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX-NEXT:    vpor %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vmovq %xmm0, %rax
; AVX-NEXT:    retq
;
; AVX512-LABEL: test_v2i64:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX512-NEXT:    vpor %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vmovq %xmm0, %rax
; AVX512-NEXT:    retq
  %1 = call i64 @llvm.experimental.vector.reduce.or.i64.v2i64(<2 x i64> %a0)
  ret i64 %1
}

define i64 @test_v4i64(<4 x i64> %a0) {
; SSE-LABEL: test_v4i64:
; SSE:       # %bb.0:
; SSE-NEXT:    por %xmm1, %xmm0
; SSE-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; SSE-NEXT:    por %xmm0, %xmm1
; SSE-NEXT:    movq %xmm1, %rax
; SSE-NEXT:    retq
;
; AVX1-LABEL: test_v4i64:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vpermilps {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vmovq %xmm0, %rax
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test_v4i64:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vextracti128 $1, %ymm0, %xmm1
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vmovq %xmm0, %rax
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512-LABEL: test_v4i64:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vextracti128 $1, %ymm0, %xmm1
; AVX512-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX512-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    vmovq %xmm0, %rax
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %1 = call i64 @llvm.experimental.vector.reduce.or.i64.v4i64(<4 x i64> %a0)
  ret i64 %1
}

define i64 @test_v8i64(<8 x i64> %a0) {
; SSE-LABEL: test_v8i64:
; SSE:       # %bb.0:
; SSE-NEXT:    por %xmm3, %xmm1
; SSE-NEXT:    por %xmm2, %xmm1
; SSE-NEXT:    por %xmm0, %xmm1
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[2,3,0,1]
; SSE-NEXT:    por %xmm1, %xmm0
; SSE-NEXT:    movq %xmm0, %rax
; SSE-NEXT:    retq
;
; AVX1-LABEL: test_v8i64:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vpermilps {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vmovq %xmm0, %rax
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test_v8i64:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vextracti128 $1, %ymm0, %xmm1
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vmovq %xmm0, %rax
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512-LABEL: test_v8i64:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vextracti64x4 $1, %zmm0, %ymm1
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vextracti128 $1, %ymm0, %xmm1
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vmovq %xmm0, %rax
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %1 = call i64 @llvm.experimental.vector.reduce.or.i64.v8i64(<8 x i64> %a0)
  ret i64 %1
}

define i64 @test_v16i64(<16 x i64> %a0) {
; SSE-LABEL: test_v16i64:
; SSE:       # %bb.0:
; SSE-NEXT:    por %xmm6, %xmm2
; SSE-NEXT:    por %xmm7, %xmm3
; SSE-NEXT:    por %xmm5, %xmm3
; SSE-NEXT:    por %xmm1, %xmm3
; SSE-NEXT:    por %xmm4, %xmm2
; SSE-NEXT:    por %xmm3, %xmm2
; SSE-NEXT:    por %xmm0, %xmm2
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = xmm2[2,3,0,1]
; SSE-NEXT:    por %xmm2, %xmm0
; SSE-NEXT:    movq %xmm0, %rax
; SSE-NEXT:    retq
;
; AVX1-LABEL: test_v16i64:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vorps %ymm3, %ymm1, %ymm1
; AVX1-NEXT:    vorps %ymm1, %ymm2, %ymm1
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vpermilps {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vmovq %xmm0, %rax
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test_v16i64:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpor %ymm3, %ymm1, %ymm1
; AVX2-NEXT:    vpor %ymm1, %ymm2, %ymm1
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vextracti128 $1, %ymm0, %xmm1
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vmovq %xmm0, %rax
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512-LABEL: test_v16i64:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vextracti64x4 $1, %zmm0, %ymm1
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vextracti128 $1, %ymm0, %xmm1
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vmovq %xmm0, %rax
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %1 = call i64 @llvm.experimental.vector.reduce.or.i64.v16i64(<16 x i64> %a0)
  ret i64 %1
}

;
; vXi32
;

define i32 @test_v4i32(<4 x i32> %a0) {
; SSE-LABEL: test_v4i32:
; SSE:       # %bb.0:
; SSE-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; SSE-NEXT:    por %xmm0, %xmm1
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[1,1,2,3]
; SSE-NEXT:    por %xmm1, %xmm0
; SSE-NEXT:    movd %xmm0, %eax
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v4i32:
; AVX:       # %bb.0:
; AVX-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX-NEXT:    vpor %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[1,1,2,3]
; AVX-NEXT:    vpor %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vmovd %xmm0, %eax
; AVX-NEXT:    retq
;
; AVX512-LABEL: test_v4i32:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX512-NEXT:    vpor %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[1,1,2,3]
; AVX512-NEXT:    vpor %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vmovd %xmm0, %eax
; AVX512-NEXT:    retq
  %1 = call i32 @llvm.experimental.vector.reduce.or.i32.v4i32(<4 x i32> %a0)
  ret i32 %1
}

define i32 @test_v8i32(<8 x i32> %a0) {
; SSE-LABEL: test_v8i32:
; SSE:       # %bb.0:
; SSE-NEXT:    por %xmm1, %xmm0
; SSE-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; SSE-NEXT:    por %xmm0, %xmm1
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[1,1,2,3]
; SSE-NEXT:    por %xmm1, %xmm0
; SSE-NEXT:    movd %xmm0, %eax
; SSE-NEXT:    retq
;
; AVX1-LABEL: test_v8i32:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vpermilps {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vpermilps {{.*#+}} xmm1 = xmm0[1,1,2,3]
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vmovd %xmm0, %eax
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test_v8i32:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vextracti128 $1, %ymm0, %xmm1
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[1,1,2,3]
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vmovd %xmm0, %eax
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512-LABEL: test_v8i32:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vextracti128 $1, %ymm0, %xmm1
; AVX512-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX512-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[1,1,2,3]
; AVX512-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    vmovd %xmm0, %eax
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %1 = call i32 @llvm.experimental.vector.reduce.or.i32.v8i32(<8 x i32> %a0)
  ret i32 %1
}

define i32 @test_v16i32(<16 x i32> %a0) {
; SSE-LABEL: test_v16i32:
; SSE:       # %bb.0:
; SSE-NEXT:    por %xmm3, %xmm1
; SSE-NEXT:    por %xmm2, %xmm1
; SSE-NEXT:    por %xmm0, %xmm1
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[2,3,0,1]
; SSE-NEXT:    por %xmm1, %xmm0
; SSE-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[1,1,2,3]
; SSE-NEXT:    por %xmm0, %xmm1
; SSE-NEXT:    movd %xmm1, %eax
; SSE-NEXT:    retq
;
; AVX1-LABEL: test_v16i32:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vpermilps {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vpermilps {{.*#+}} xmm1 = xmm0[1,1,2,3]
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vmovd %xmm0, %eax
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test_v16i32:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vextracti128 $1, %ymm0, %xmm1
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[1,1,2,3]
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vmovd %xmm0, %eax
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512-LABEL: test_v16i32:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vextracti64x4 $1, %zmm0, %ymm1
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vextracti128 $1, %ymm0, %xmm1
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[1,1,2,3]
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vmovd %xmm0, %eax
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %1 = call i32 @llvm.experimental.vector.reduce.or.i32.v16i32(<16 x i32> %a0)
  ret i32 %1
}

define i32 @test_v32i32(<32 x i32> %a0) {
; SSE-LABEL: test_v32i32:
; SSE:       # %bb.0:
; SSE-NEXT:    por %xmm6, %xmm2
; SSE-NEXT:    por %xmm7, %xmm3
; SSE-NEXT:    por %xmm5, %xmm3
; SSE-NEXT:    por %xmm1, %xmm3
; SSE-NEXT:    por %xmm4, %xmm2
; SSE-NEXT:    por %xmm3, %xmm2
; SSE-NEXT:    por %xmm0, %xmm2
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = xmm2[2,3,0,1]
; SSE-NEXT:    por %xmm2, %xmm0
; SSE-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[1,1,2,3]
; SSE-NEXT:    por %xmm0, %xmm1
; SSE-NEXT:    movd %xmm1, %eax
; SSE-NEXT:    retq
;
; AVX1-LABEL: test_v32i32:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vorps %ymm3, %ymm1, %ymm1
; AVX1-NEXT:    vorps %ymm1, %ymm2, %ymm1
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vpermilps {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vpermilps {{.*#+}} xmm1 = xmm0[1,1,2,3]
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vmovd %xmm0, %eax
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test_v32i32:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpor %ymm3, %ymm1, %ymm1
; AVX2-NEXT:    vpor %ymm1, %ymm2, %ymm1
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vextracti128 $1, %ymm0, %xmm1
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[1,1,2,3]
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vmovd %xmm0, %eax
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512-LABEL: test_v32i32:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vextracti64x4 $1, %zmm0, %ymm1
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vextracti128 $1, %ymm0, %xmm1
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[1,1,2,3]
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vmovd %xmm0, %eax
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %1 = call i32 @llvm.experimental.vector.reduce.or.i32.v32i32(<32 x i32> %a0)
  ret i32 %1
}

;
; vXi16
;

define i16 @test_v8i16(<8 x i16> %a0) {
; SSE-LABEL: test_v8i16:
; SSE:       # %bb.0:
; SSE-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; SSE-NEXT:    por %xmm0, %xmm1
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[1,1,2,3]
; SSE-NEXT:    por %xmm1, %xmm0
; SSE-NEXT:    movdqa %xmm0, %xmm1
; SSE-NEXT:    psrld $16, %xmm1
; SSE-NEXT:    por %xmm0, %xmm1
; SSE-NEXT:    movd %xmm1, %eax
; SSE-NEXT:    # kill: def $ax killed $ax killed $eax
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v8i16:
; AVX:       # %bb.0:
; AVX-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX-NEXT:    vpor %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[1,1,2,3]
; AVX-NEXT:    vpor %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpsrld $16, %xmm0, %xmm1
; AVX-NEXT:    vpor %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vmovd %xmm0, %eax
; AVX-NEXT:    # kill: def $ax killed $ax killed $eax
; AVX-NEXT:    retq
;
; AVX512-LABEL: test_v8i16:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX512-NEXT:    vpor %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[1,1,2,3]
; AVX512-NEXT:    vpor %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vpsrld $16, %xmm0, %xmm1
; AVX512-NEXT:    vpor %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vmovd %xmm0, %eax
; AVX512-NEXT:    # kill: def $ax killed $ax killed $eax
; AVX512-NEXT:    retq
  %1 = call i16 @llvm.experimental.vector.reduce.or.i16.v8i16(<8 x i16> %a0)
  ret i16 %1
}

define i16 @test_v16i16(<16 x i16> %a0) {
; SSE-LABEL: test_v16i16:
; SSE:       # %bb.0:
; SSE-NEXT:    por %xmm1, %xmm0
; SSE-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; SSE-NEXT:    por %xmm0, %xmm1
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[1,1,2,3]
; SSE-NEXT:    por %xmm1, %xmm0
; SSE-NEXT:    movdqa %xmm0, %xmm1
; SSE-NEXT:    psrld $16, %xmm1
; SSE-NEXT:    por %xmm0, %xmm1
; SSE-NEXT:    movd %xmm1, %eax
; SSE-NEXT:    # kill: def $ax killed $ax killed $eax
; SSE-NEXT:    retq
;
; AVX1-LABEL: test_v16i16:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vpermilps {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vpermilps {{.*#+}} xmm1 = xmm0[1,1,2,3]
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vpsrld $16, %xmm0, %xmm1
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vmovd %xmm0, %eax
; AVX1-NEXT:    # kill: def $ax killed $ax killed $eax
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test_v16i16:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vextracti128 $1, %ymm0, %xmm1
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[1,1,2,3]
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpsrld $16, %xmm0, %xmm1
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vmovd %xmm0, %eax
; AVX2-NEXT:    # kill: def $ax killed $ax killed $eax
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512-LABEL: test_v16i16:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vextracti128 $1, %ymm0, %xmm1
; AVX512-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX512-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[1,1,2,3]
; AVX512-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    vpsrld $16, %xmm0, %xmm1
; AVX512-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    vmovd %xmm0, %eax
; AVX512-NEXT:    # kill: def $ax killed $ax killed $eax
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %1 = call i16 @llvm.experimental.vector.reduce.or.i16.v16i16(<16 x i16> %a0)
  ret i16 %1
}

define i16 @test_v32i16(<32 x i16> %a0) {
; SSE-LABEL: test_v32i16:
; SSE:       # %bb.0:
; SSE-NEXT:    por %xmm3, %xmm1
; SSE-NEXT:    por %xmm2, %xmm1
; SSE-NEXT:    por %xmm0, %xmm1
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[2,3,0,1]
; SSE-NEXT:    por %xmm1, %xmm0
; SSE-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[1,1,2,3]
; SSE-NEXT:    por %xmm0, %xmm1
; SSE-NEXT:    movdqa %xmm1, %xmm0
; SSE-NEXT:    psrld $16, %xmm0
; SSE-NEXT:    por %xmm1, %xmm0
; SSE-NEXT:    movd %xmm0, %eax
; SSE-NEXT:    # kill: def $ax killed $ax killed $eax
; SSE-NEXT:    retq
;
; AVX1-LABEL: test_v32i16:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vpermilps {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vpermilps {{.*#+}} xmm1 = xmm0[1,1,2,3]
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vpsrld $16, %xmm0, %xmm1
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vmovd %xmm0, %eax
; AVX1-NEXT:    # kill: def $ax killed $ax killed $eax
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test_v32i16:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vextracti128 $1, %ymm0, %xmm1
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[1,1,2,3]
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpsrld $16, %xmm0, %xmm1
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vmovd %xmm0, %eax
; AVX2-NEXT:    # kill: def $ax killed $ax killed $eax
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512-LABEL: test_v32i16:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vextracti64x4 $1, %zmm0, %ymm1
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vextracti128 $1, %ymm0, %xmm1
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[1,1,2,3]
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vpsrld $16, %xmm0, %xmm1
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vmovd %xmm0, %eax
; AVX512-NEXT:    # kill: def $ax killed $ax killed $eax
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %1 = call i16 @llvm.experimental.vector.reduce.or.i16.v32i16(<32 x i16> %a0)
  ret i16 %1
}

define i16 @test_v64i16(<64 x i16> %a0) {
; SSE-LABEL: test_v64i16:
; SSE:       # %bb.0:
; SSE-NEXT:    por %xmm6, %xmm2
; SSE-NEXT:    por %xmm7, %xmm3
; SSE-NEXT:    por %xmm5, %xmm3
; SSE-NEXT:    por %xmm1, %xmm3
; SSE-NEXT:    por %xmm4, %xmm2
; SSE-NEXT:    por %xmm3, %xmm2
; SSE-NEXT:    por %xmm0, %xmm2
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = xmm2[2,3,0,1]
; SSE-NEXT:    por %xmm2, %xmm0
; SSE-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[1,1,2,3]
; SSE-NEXT:    por %xmm0, %xmm1
; SSE-NEXT:    movdqa %xmm1, %xmm0
; SSE-NEXT:    psrld $16, %xmm0
; SSE-NEXT:    por %xmm1, %xmm0
; SSE-NEXT:    movd %xmm0, %eax
; SSE-NEXT:    # kill: def $ax killed $ax killed $eax
; SSE-NEXT:    retq
;
; AVX1-LABEL: test_v64i16:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vorps %ymm3, %ymm1, %ymm1
; AVX1-NEXT:    vorps %ymm1, %ymm2, %ymm1
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vpermilps {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vpermilps {{.*#+}} xmm1 = xmm0[1,1,2,3]
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vpsrld $16, %xmm0, %xmm1
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vmovd %xmm0, %eax
; AVX1-NEXT:    # kill: def $ax killed $ax killed $eax
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test_v64i16:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpor %ymm3, %ymm1, %ymm1
; AVX2-NEXT:    vpor %ymm1, %ymm2, %ymm1
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vextracti128 $1, %ymm0, %xmm1
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[1,1,2,3]
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpsrld $16, %xmm0, %xmm1
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vmovd %xmm0, %eax
; AVX2-NEXT:    # kill: def $ax killed $ax killed $eax
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512-LABEL: test_v64i16:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vextracti64x4 $1, %zmm0, %ymm1
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vextracti128 $1, %ymm0, %xmm1
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[1,1,2,3]
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vpsrld $16, %xmm0, %xmm1
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vmovd %xmm0, %eax
; AVX512-NEXT:    # kill: def $ax killed $ax killed $eax
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %1 = call i16 @llvm.experimental.vector.reduce.or.i16.v64i16(<64 x i16> %a0)
  ret i16 %1
}

;
; vXi8
;

define i8 @test_v16i8(<16 x i8> %a0) {
; SSE2-LABEL: test_v16i8:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; SSE2-NEXT:    por %xmm0, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[1,1,2,3]
; SSE2-NEXT:    por %xmm1, %xmm0
; SSE2-NEXT:    movdqa %xmm0, %xmm1
; SSE2-NEXT:    psrld $16, %xmm1
; SSE2-NEXT:    por %xmm0, %xmm1
; SSE2-NEXT:    movdqa %xmm1, %xmm0
; SSE2-NEXT:    psrlw $8, %xmm0
; SSE2-NEXT:    por %xmm1, %xmm0
; SSE2-NEXT:    movd %xmm0, %eax
; SSE2-NEXT:    # kill: def $al killed $al killed $eax
; SSE2-NEXT:    retq
;
; SSE41-LABEL: test_v16i8:
; SSE41:       # %bb.0:
; SSE41-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; SSE41-NEXT:    por %xmm0, %xmm1
; SSE41-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[1,1,2,3]
; SSE41-NEXT:    por %xmm1, %xmm0
; SSE41-NEXT:    movdqa %xmm0, %xmm1
; SSE41-NEXT:    psrld $16, %xmm1
; SSE41-NEXT:    por %xmm0, %xmm1
; SSE41-NEXT:    movdqa %xmm1, %xmm0
; SSE41-NEXT:    psrlw $8, %xmm0
; SSE41-NEXT:    por %xmm1, %xmm0
; SSE41-NEXT:    pextrb $0, %xmm0, %eax
; SSE41-NEXT:    # kill: def $al killed $al killed $eax
; SSE41-NEXT:    retq
;
; AVX-LABEL: test_v16i8:
; AVX:       # %bb.0:
; AVX-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX-NEXT:    vpor %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[1,1,2,3]
; AVX-NEXT:    vpor %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpsrld $16, %xmm0, %xmm1
; AVX-NEXT:    vpor %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpsrlw $8, %xmm0, %xmm1
; AVX-NEXT:    vpor %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpextrb $0, %xmm0, %eax
; AVX-NEXT:    # kill: def $al killed $al killed $eax
; AVX-NEXT:    retq
;
; AVX512-LABEL: test_v16i8:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX512-NEXT:    vpor %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[1,1,2,3]
; AVX512-NEXT:    vpor %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vpsrld $16, %xmm0, %xmm1
; AVX512-NEXT:    vpor %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vpsrlw $8, %xmm0, %xmm1
; AVX512-NEXT:    vpor %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vpextrb $0, %xmm0, %eax
; AVX512-NEXT:    # kill: def $al killed $al killed $eax
; AVX512-NEXT:    retq
  %1 = call i8 @llvm.experimental.vector.reduce.or.i8.v16i8(<16 x i8> %a0)
  ret i8 %1
}

define i8 @test_v32i8(<32 x i8> %a0) {
; SSE2-LABEL: test_v32i8:
; SSE2:       # %bb.0:
; SSE2-NEXT:    por %xmm1, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; SSE2-NEXT:    por %xmm0, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[1,1,2,3]
; SSE2-NEXT:    por %xmm1, %xmm0
; SSE2-NEXT:    movdqa %xmm0, %xmm1
; SSE2-NEXT:    psrld $16, %xmm1
; SSE2-NEXT:    por %xmm0, %xmm1
; SSE2-NEXT:    movdqa %xmm1, %xmm0
; SSE2-NEXT:    psrlw $8, %xmm0
; SSE2-NEXT:    por %xmm1, %xmm0
; SSE2-NEXT:    movd %xmm0, %eax
; SSE2-NEXT:    # kill: def $al killed $al killed $eax
; SSE2-NEXT:    retq
;
; SSE41-LABEL: test_v32i8:
; SSE41:       # %bb.0:
; SSE41-NEXT:    por %xmm1, %xmm0
; SSE41-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; SSE41-NEXT:    por %xmm0, %xmm1
; SSE41-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[1,1,2,3]
; SSE41-NEXT:    por %xmm1, %xmm0
; SSE41-NEXT:    movdqa %xmm0, %xmm1
; SSE41-NEXT:    psrld $16, %xmm1
; SSE41-NEXT:    por %xmm0, %xmm1
; SSE41-NEXT:    movdqa %xmm1, %xmm0
; SSE41-NEXT:    psrlw $8, %xmm0
; SSE41-NEXT:    por %xmm1, %xmm0
; SSE41-NEXT:    pextrb $0, %xmm0, %eax
; SSE41-NEXT:    # kill: def $al killed $al killed $eax
; SSE41-NEXT:    retq
;
; AVX1-LABEL: test_v32i8:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vpermilps {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vpermilps {{.*#+}} xmm1 = xmm0[1,1,2,3]
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vpsrld $16, %xmm0, %xmm1
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vpsrlw $8, %xmm0, %xmm1
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vpextrb $0, %xmm0, %eax
; AVX1-NEXT:    # kill: def $al killed $al killed $eax
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test_v32i8:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vextracti128 $1, %ymm0, %xmm1
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[1,1,2,3]
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpsrld $16, %xmm0, %xmm1
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpsrlw $8, %xmm0, %xmm1
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpextrb $0, %xmm0, %eax
; AVX2-NEXT:    # kill: def $al killed $al killed $eax
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512-LABEL: test_v32i8:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vextracti128 $1, %ymm0, %xmm1
; AVX512-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX512-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[1,1,2,3]
; AVX512-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    vpsrld $16, %xmm0, %xmm1
; AVX512-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    vpsrlw $8, %xmm0, %xmm1
; AVX512-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    vpextrb $0, %xmm0, %eax
; AVX512-NEXT:    # kill: def $al killed $al killed $eax
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %1 = call i8 @llvm.experimental.vector.reduce.or.i8.v32i8(<32 x i8> %a0)
  ret i8 %1
}

define i8 @test_v64i8(<64 x i8> %a0) {
; SSE2-LABEL: test_v64i8:
; SSE2:       # %bb.0:
; SSE2-NEXT:    por %xmm3, %xmm1
; SSE2-NEXT:    por %xmm2, %xmm1
; SSE2-NEXT:    por %xmm0, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[2,3,0,1]
; SSE2-NEXT:    por %xmm1, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[1,1,2,3]
; SSE2-NEXT:    por %xmm0, %xmm1
; SSE2-NEXT:    movdqa %xmm1, %xmm0
; SSE2-NEXT:    psrld $16, %xmm0
; SSE2-NEXT:    por %xmm1, %xmm0
; SSE2-NEXT:    movdqa %xmm0, %xmm1
; SSE2-NEXT:    psrlw $8, %xmm1
; SSE2-NEXT:    por %xmm0, %xmm1
; SSE2-NEXT:    movd %xmm1, %eax
; SSE2-NEXT:    # kill: def $al killed $al killed $eax
; SSE2-NEXT:    retq
;
; SSE41-LABEL: test_v64i8:
; SSE41:       # %bb.0:
; SSE41-NEXT:    por %xmm3, %xmm1
; SSE41-NEXT:    por %xmm2, %xmm1
; SSE41-NEXT:    por %xmm0, %xmm1
; SSE41-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[2,3,0,1]
; SSE41-NEXT:    por %xmm1, %xmm0
; SSE41-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[1,1,2,3]
; SSE41-NEXT:    por %xmm0, %xmm1
; SSE41-NEXT:    movdqa %xmm1, %xmm0
; SSE41-NEXT:    psrld $16, %xmm0
; SSE41-NEXT:    por %xmm1, %xmm0
; SSE41-NEXT:    movdqa %xmm0, %xmm1
; SSE41-NEXT:    psrlw $8, %xmm1
; SSE41-NEXT:    por %xmm0, %xmm1
; SSE41-NEXT:    pextrb $0, %xmm1, %eax
; SSE41-NEXT:    # kill: def $al killed $al killed $eax
; SSE41-NEXT:    retq
;
; AVX1-LABEL: test_v64i8:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vpermilps {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vpermilps {{.*#+}} xmm1 = xmm0[1,1,2,3]
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vpsrld $16, %xmm0, %xmm1
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vpsrlw $8, %xmm0, %xmm1
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vpextrb $0, %xmm0, %eax
; AVX1-NEXT:    # kill: def $al killed $al killed $eax
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test_v64i8:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vextracti128 $1, %ymm0, %xmm1
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[1,1,2,3]
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpsrld $16, %xmm0, %xmm1
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpsrlw $8, %xmm0, %xmm1
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpextrb $0, %xmm0, %eax
; AVX2-NEXT:    # kill: def $al killed $al killed $eax
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512-LABEL: test_v64i8:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vextracti64x4 $1, %zmm0, %ymm1
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vextracti128 $1, %ymm0, %xmm1
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[1,1,2,3]
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vpsrld $16, %xmm0, %xmm1
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vpsrlw $8, %xmm0, %xmm1
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vpextrb $0, %xmm0, %eax
; AVX512-NEXT:    # kill: def $al killed $al killed $eax
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %1 = call i8 @llvm.experimental.vector.reduce.or.i8.v64i8(<64 x i8> %a0)
  ret i8 %1
}

define i8 @test_v128i8(<128 x i8> %a0) {
; SSE2-LABEL: test_v128i8:
; SSE2:       # %bb.0:
; SSE2-NEXT:    por %xmm6, %xmm2
; SSE2-NEXT:    por %xmm7, %xmm3
; SSE2-NEXT:    por %xmm5, %xmm3
; SSE2-NEXT:    por %xmm1, %xmm3
; SSE2-NEXT:    por %xmm4, %xmm2
; SSE2-NEXT:    por %xmm3, %xmm2
; SSE2-NEXT:    por %xmm0, %xmm2
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm2[2,3,0,1]
; SSE2-NEXT:    por %xmm2, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[1,1,2,3]
; SSE2-NEXT:    por %xmm0, %xmm1
; SSE2-NEXT:    movdqa %xmm1, %xmm0
; SSE2-NEXT:    psrld $16, %xmm0
; SSE2-NEXT:    por %xmm1, %xmm0
; SSE2-NEXT:    movdqa %xmm0, %xmm1
; SSE2-NEXT:    psrlw $8, %xmm1
; SSE2-NEXT:    por %xmm0, %xmm1
; SSE2-NEXT:    movd %xmm1, %eax
; SSE2-NEXT:    # kill: def $al killed $al killed $eax
; SSE2-NEXT:    retq
;
; SSE41-LABEL: test_v128i8:
; SSE41:       # %bb.0:
; SSE41-NEXT:    por %xmm6, %xmm2
; SSE41-NEXT:    por %xmm7, %xmm3
; SSE41-NEXT:    por %xmm5, %xmm3
; SSE41-NEXT:    por %xmm1, %xmm3
; SSE41-NEXT:    por %xmm4, %xmm2
; SSE41-NEXT:    por %xmm3, %xmm2
; SSE41-NEXT:    por %xmm0, %xmm2
; SSE41-NEXT:    pshufd {{.*#+}} xmm0 = xmm2[2,3,0,1]
; SSE41-NEXT:    por %xmm2, %xmm0
; SSE41-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[1,1,2,3]
; SSE41-NEXT:    por %xmm0, %xmm1
; SSE41-NEXT:    movdqa %xmm1, %xmm0
; SSE41-NEXT:    psrld $16, %xmm0
; SSE41-NEXT:    por %xmm1, %xmm0
; SSE41-NEXT:    movdqa %xmm0, %xmm1
; SSE41-NEXT:    psrlw $8, %xmm1
; SSE41-NEXT:    por %xmm0, %xmm1
; SSE41-NEXT:    pextrb $0, %xmm1, %eax
; SSE41-NEXT:    # kill: def $al killed $al killed $eax
; SSE41-NEXT:    retq
;
; AVX1-LABEL: test_v128i8:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vorps %ymm3, %ymm1, %ymm1
; AVX1-NEXT:    vorps %ymm1, %ymm2, %ymm1
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vpermilps {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vpermilps {{.*#+}} xmm1 = xmm0[1,1,2,3]
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vpsrld $16, %xmm0, %xmm1
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vpsrlw $8, %xmm0, %xmm1
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vpextrb $0, %xmm0, %eax
; AVX1-NEXT:    # kill: def $al killed $al killed $eax
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test_v128i8:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpor %ymm3, %ymm1, %ymm1
; AVX2-NEXT:    vpor %ymm1, %ymm2, %ymm1
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vextracti128 $1, %ymm0, %xmm1
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[1,1,2,3]
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpsrld $16, %xmm0, %xmm1
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpsrlw $8, %xmm0, %xmm1
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpextrb $0, %xmm0, %eax
; AVX2-NEXT:    # kill: def $al killed $al killed $eax
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512-LABEL: test_v128i8:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vextracti64x4 $1, %zmm0, %ymm1
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vextracti128 $1, %ymm0, %xmm1
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[1,1,2,3]
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vpsrld $16, %xmm0, %xmm1
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vpsrlw $8, %xmm0, %xmm1
; AVX512-NEXT:    vporq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vpextrb $0, %xmm0, %eax
; AVX512-NEXT:    # kill: def $al killed $al killed $eax
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %1 = call i8 @llvm.experimental.vector.reduce.or.i8.v128i8(<128 x i8> %a0)
  ret i8 %1
}

declare i64 @llvm.experimental.vector.reduce.or.i64.v2i64(<2 x i64>)
declare i64 @llvm.experimental.vector.reduce.or.i64.v4i64(<4 x i64>)
declare i64 @llvm.experimental.vector.reduce.or.i64.v8i64(<8 x i64>)
declare i64 @llvm.experimental.vector.reduce.or.i64.v16i64(<16 x i64>)

declare i32 @llvm.experimental.vector.reduce.or.i32.v4i32(<4 x i32>)
declare i32 @llvm.experimental.vector.reduce.or.i32.v8i32(<8 x i32>)
declare i32 @llvm.experimental.vector.reduce.or.i32.v16i32(<16 x i32>)
declare i32 @llvm.experimental.vector.reduce.or.i32.v32i32(<32 x i32>)

declare i16 @llvm.experimental.vector.reduce.or.i16.v8i16(<8 x i16>)
declare i16 @llvm.experimental.vector.reduce.or.i16.v16i16(<16 x i16>)
declare i16 @llvm.experimental.vector.reduce.or.i16.v32i16(<32 x i16>)
declare i16 @llvm.experimental.vector.reduce.or.i16.v64i16(<64 x i16>)

declare i8 @llvm.experimental.vector.reduce.or.i8.v16i8(<16 x i8>)
declare i8 @llvm.experimental.vector.reduce.or.i8.v32i8(<32 x i8>)
declare i8 @llvm.experimental.vector.reduce.or.i8.v64i8(<64 x i8>)
declare i8 @llvm.experimental.vector.reduce.or.i8.v128i8(<128 x i8>)
