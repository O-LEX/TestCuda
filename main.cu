#include <iostream>
#include <cuda_runtime.h>

// CUDAカーネル関数: 2つの整数を足し算
__global__ void addKernel(int a, int b, int *result) {
    *result = a + b;
}

// ホスト関数: GPUで加算を実行する
int addGPU(int a, int b) {
    int *d_result;    // デバイスメモリ用のポインタ
    int h_result;     // ホストメモリ用の変数

    // デバイスメモリの確保
    cudaMalloc((void**)&d_result, sizeof(int));

    // カーネルの呼び出し (1つのスレッドで実行)
    addKernel<<<1, 1>>>(a, b, d_result);

    // エラー処理
    cudaError_t err = cudaGetLastError();
    if (err != cudaSuccess) {
        std::cerr << "CUDA error: " << cudaGetErrorString(err) << std::endl;
        return -1;
    }

    // デバイスからホストへ結果をコピー
    cudaMemcpy(&h_result, d_result, sizeof(int), cudaMemcpyDeviceToHost);

    // デバイスメモリを解放
    cudaFree(d_result);

    return h_result;
}
