<?php

// routes/api.php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\TitleController; // <-- WAJIB: Import Controller

/* Public Routes */
Route::post('/login', [AuthController::class, 'login']);
Route::post('/register', [AuthController::class, 'register']);


/* Protected Routes (Butuh Token Sanctum) */
Route::middleware('auth:sanctum')->group(function () {
    
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/user-profile', [AuthController::class, 'userProfile']);

    // PASTI BARRIS INI ADA DI DALAM GROUP INI:
    // Resource route akan otomatis membuat POST /api/titles
    Route::resource('titles', TitleController::class)->only(['store', 'index', 'show']); 
    
    // Pastikan juga route upload proposal (untuk langkah selanjutnya) ada
    Route::post('titles/{title}/upload-proposal', [TitleController::class, 'uploadProposal']);
});