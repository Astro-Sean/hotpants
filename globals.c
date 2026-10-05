#include "globals.h"

/* GLOBAL VARS POSSIBLY SET ON COMMAND LINE */
char      *template, *image, *outim;

float     tUThresh, tUKThresh, tLThresh, tGain, tRdnoise, iUThresh, iUKThresh, iLThresh, iGain, iRdnoise;
char      *tNoiseIm, *iNoiseIm, *tMaskIm, *iMaskIm, *kernelImIn, *kernelImOut, *outMask;
float     tPedestal, iPedestal;
int       hwKernel;
float     kerFitThresh, scaleFitThresh, minFracGoodStamps;
float     kfSpreadMask1, kfSpreadMask2;
int       gdXmin, gdXmax, gdYmin, gdYmax;
int       nRegX, nRegY;
char      *regFile;
char      *regKeyWord;
int       numRegKeyWord;
int       nStampY, nStampX, useFullSS;
int       nKSStamps, hwKSStamp;
char      *sstampFile;
int       findSSC;
int       kerOrder, bgOrder;
float     statSig, kerSigReject, kerFracMask;
char      *forceConvolve, *photNormalize, *figMerit;
int       sameConv, rescaleOK;
float     fillVal, fillValNoise;
char      *effFile, *noiseImage, *sigmaImage, *convImage;
int       doSum, inclNoiseImage, inclSigmaImage, inclConvImage, noClobber;
int       doKerInfo, outShort, outNShort;
float     outBzero, outBscale, outNiBzero, outNiBscale;
int       convolveVariance;
int       usePCA, fwKernelPCA;
float     **PCA;

/* GLOBAL VARS NOT SET ON COMMAND LINE */
int       ngauss, *deg_fixe;
float     *sigma_gauss;

int       rPixX, rPixY;
int       nStamps, nS, nCompKer, nC;

int       nComp, nCompBG, nBGVectors, nCompTotal;

int       fwKernel, fwStamp, hwStamp, fwKSStamp, kcStep, *indx;
int       cmpFile;
float     *temp, *temp2;
double    *check_stack,*filter_x,*filter_y,**kernel_vec;
double    **wxy,*kernel_coeffs,*kernel,**check_mat,*check_vec;
char      version[32];

/* REGION SIZED */
int       *mRData;   /* bad input data mask */

/* armin */
/* a dummy varialbe to do some testing */
int        dummy;
/* verbose for debugging */
int        verbose;
/* cmp file stuff */
char       xyfilename[1000];
int        savexyflag;
float      *xcmp,*ycmp;
int        Ncmp;
