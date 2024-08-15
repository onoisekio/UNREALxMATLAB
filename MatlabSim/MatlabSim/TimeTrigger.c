/*
 * File: TimeTrigger.c
 *
 *
 *   --- THIS FILE GENERATED BY S-FUNCTION BUILDER: 3.0 ---
 *
 *   This file is an S-function produced by the S-Function
 *   Builder which only recognizes certain fields.  Changes made
 *   outside these fields will be lost the next time the block is
 *   used to load, edit, and resave this file. This file will be overwritten
 *   by the S-function Builder block. If you want to edit this file by hand,
 *   you must change it only in the area defined as:
 *
 *        %%%-SFUNWIZ_defines_Changes_BEGIN
 *        #define NAME 'replacement text'
 *        %%% SFUNWIZ_defines_Changes_END
 *
 *   DO NOT change NAME--Change the 'replacement text' only.
 *
 *   For better compatibility with the Simulink Coder, the
 *   "wrapper" S-function technique is used.  This is discussed
 *   in the Simulink Coder's Manual in the Chapter titled,
 *   "Wrapper S-functions".
 *
 *  -------------------------------------------------------------------------
 * | See matlabroot/simulink/src/sfuntmpl_doc.c for a more detailed template |
 *  -------------------------------------------------------------------------
 *
 * Created: Thu Dec 28 13:25:53 2023
 */

#define S_FUNCTION_LEVEL               2
#define S_FUNCTION_NAME                TimeTrigger

/*<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*/
/* %%%-SFUNWIZ_defines_Changes_BEGIN --- EDIT HERE TO _END */
#define NUM_INPUTS                     1

/* Input Port  0 */
#define IN_PORT_0_NAME                 u0
#define INPUT_0_WIDTH                  66
#define INPUT_DIMS_0_COL               2
#define INPUT_0_DTYPE                  real_T
#define INPUT_0_COMPLEX                COMPLEX_NO
#define IN_0_FRAME_BASED               FRAME_NO
#define IN_0_BUS_BASED                 0
#define IN_0_BUS_NAME
#define IN_0_DIMS                      2-D
#define INPUT_0_FEEDTHROUGH            1
#define IN_0_ISSIGNED                  0
#define IN_0_WORDLENGTH                8
#define IN_0_FIXPOINTSCALING           1
#define IN_0_FRACTIONLENGTH            9
#define IN_0_BIAS                      0
#define IN_0_SLOPE                     0.125
#define NUM_OUTPUTS                    1

/* Output Port  0 */
#define OUT_PORT_0_NAME                y0
#define OUTPUT_0_WIDTH                 1
#define OUTPUT_DIMS_0_COL              1
#define OUTPUT_0_DTYPE                 real_T
#define OUTPUT_0_COMPLEX               COMPLEX_NO
#define OUT_0_FRAME_BASED              FRAME_NO
#define OUT_0_BUS_BASED                0
#define OUT_0_BUS_NAME
#define OUT_0_DIMS                     1-D
#define OUT_0_ISSIGNED                 1
#define OUT_0_WORDLENGTH               8
#define OUT_0_FIXPOINTSCALING          1
#define OUT_0_FRACTIONLENGTH           3
#define OUT_0_BIAS                     0
#define OUT_0_SLOPE                    0.125
#define NPARAMS                        0
#define SAMPLE_TIME_0                  1
#define NUM_DISC_STATES                2
#define DISC_STATES_IC                 [1,1]
#define NUM_CONT_STATES                0
#define CONT_STATES_IC                 [0]
#define SFUNWIZ_GENERATE_TLC           0
#define SOURCEFILES                    "__SFB__"
#define PANELINDEX                     N/A
#define USE_SIMSTRUCT                  1
#define SHOW_COMPILE_STEPS             0
#define CREATE_DEBUG_MEXFILE           0
#define SAVE_CODE_ONLY                 0
#define SFUNWIZ_REVISION               3.0

/* %%%-SFUNWIZ_defines_Changes_END --- EDIT HERE TO _BEGIN */
/*<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*/
#include "simstruc.h"

extern void TimeTrigger_Outputs_wrapper(const real_T *u0,
  real_T *y0,
  const real_T *xD,
  SimStruct *S);
extern void TimeTrigger_Update_wrapper(const real_T *u0,
  real_T *y0,
  real_T *xD,
  SimStruct *S);

/*====================*
 * S-function methods *
 *====================*/
/* Function: mdlInitializeSizes ===============================================
 * Abstract:
 *   Setup sizes of the various vectors.
 */
static void mdlInitializeSizes(SimStruct *S)
{
  DECL_AND_INIT_DIMSINFO(inputDimsInfo);
  DECL_AND_INIT_DIMSINFO(outputDimsInfo);
  ssSetNumSFcnParams(S, NPARAMS);
  if (ssGetNumSFcnParams(S) != ssGetSFcnParamsCount(S)) {
    return;                            /* Parameter mismatch will be reported by Simulink */
  }

  ssSetArrayLayoutForCodeGen(S, SS_COLUMN_MAJOR);
  ssSetOperatingPointCompliance(S, USE_DEFAULT_OPERATING_POINT);
  ssSetNumContStates(S, NUM_CONT_STATES);
  ssSetNumDiscStates(S, NUM_DISC_STATES);
  if (!ssSetNumInputPorts(S, NUM_INPUTS))
    return;

  /* Input Port 0 */
  inputDimsInfo.width = INPUT_0_WIDTH;
  ssSetInputPortDimensionInfo(S, 0, &inputDimsInfo);
  ssSetInputPortMatrixDimensions(S, 0, INPUT_0_WIDTH, INPUT_DIMS_0_COL);
  ssSetInputPortFrameData(S, 0, IN_0_FRAME_BASED);
  ssSetInputPortDataType(S, 0, SS_DOUBLE);
  ssSetInputPortComplexSignal(S, 0, INPUT_0_COMPLEX);
  ssSetInputPortDirectFeedThrough(S, 0, INPUT_0_FEEDTHROUGH);
  ssSetInputPortRequiredContiguous(S, 0, 1);/*direct input signal access*/
  if (!ssSetNumOutputPorts(S, NUM_OUTPUTS))
    return;

  /* Output Port 0 */
  ssSetOutputPortWidth(S, 0, OUTPUT_0_WIDTH);
  ssSetOutputPortDataType(S, 0, SS_DOUBLE);
  ssSetOutputPortComplexSignal(S, 0, OUTPUT_0_COMPLEX);
  ssSetNumPWork(S, 0);
  ssSetNumSampleTimes(S, 1);
  ssSetNumRWork(S, 0);
  ssSetNumIWork(S, 0);
  ssSetNumModes(S, 0);
  ssSetNumNonsampledZCs(S, 0);
  ssSetSimulinkVersionGeneratedIn(S, "10.5");

  /* Take care when specifying exception free code - see sfuntmpl_doc.c */
  ssSetOptions(S, (SS_OPTION_EXCEPTION_FREE_CODE |
                   SS_OPTION_WORKS_WITH_CODE_REUSE));
}

#define MDL_SET_INPUT_PORT_DIMENSION_INFO

void mdlSetInputPortDimensionInfo(SimStruct *S,
  int portIndex,
  const DimsInfo_T *dimsInfo)
{
  DECL_AND_INIT_DIMSINFO(portDimsInfo);
  int_T dims[2] = { OUTPUT_0_WIDTH, 1 };

  bool frameIn = (ssGetInputPortFrameData(S, 0) == FRAME_YES);
  ssSetInputPortDimensionInfo(S, 0, dimsInfo);
  if (ssGetOutputPortNumDimensions(S, 0) == (-1)) {
    /* the output port has not been set */
    portDimsInfo.width = OUTPUT_0_WIDTH;
    portDimsInfo.numDims = frameIn ? 2 : 1;
    portDimsInfo.dims = frameIn ? dims : &portDimsInfo.width;
    ssSetOutputPortDimensionInfo(S, 0, &portDimsInfo);
  }
}

#define MDL_SET_OUTPUT_PORT_DIMENSION_INFO

void mdlSetOutputPortDimensionInfo(SimStruct *S,
  int_T portIndex,
  const DimsInfo_T *dimsInfo)
{
  DECL_AND_INIT_DIMSINFO(portDimsInfo);
  int_T dims[2] = { OUTPUT_0_WIDTH, 1 };

  bool frameOut = (ssGetOutputPortFrameData(S, 0) == FRAME_YES);
  ssSetOutputPortDimensionInfo(S, 0, dimsInfo);
  if (ssGetInputPortNumDimensions(S, 0) == (-1)) {
    /* the input port has not been set */
    portDimsInfo.width = INPUT_0_WIDTH;
    portDimsInfo.numDims = frameOut ? 2 : 1;
    portDimsInfo.dims = frameOut ? dims : &portDimsInfo.width;
    ssSetInputPortDimensionInfo(S, 0, &portDimsInfo);
  }
}

#define MDL_SET_DEFAULT_PORT_DIMENSION_INFO

static void mdlSetDefaultPortDimensionInfo(SimStruct *S)
{
  DECL_AND_INIT_DIMSINFO(portDimsInfo);
  int_T dims[2] = { INPUT_0_WIDTH, 1 };

  bool frameIn = ssGetInputPortFrameData(S, 0) == FRAME_YES;

  /* Neither the input nor the output ports have been set */
  portDimsInfo.width = INPUT_0_WIDTH;
  portDimsInfo.numDims = frameIn ? 2 : 1;
  portDimsInfo.dims = frameIn ? dims : &portDimsInfo.width;
  if (ssGetInputPortNumDimensions(S, 0) == (-1)) {
    ssSetInputPortDimensionInfo(S, 0, &portDimsInfo);
  }

  portDimsInfo.width = OUTPUT_0_WIDTH;
  dims[0] = OUTPUT_0_WIDTH;
  if (ssGetOutputPortNumDimensions(S, 0) == (-1)) {
    ssSetOutputPortDimensionInfo(S, 0, &portDimsInfo);
  }

  return;
}

/* Function: mdlInitializeSampleTimes =========================================
 * Abstract:
 *    Specifiy  the sample time.
 */
static void mdlInitializeSampleTimes(SimStruct *S)
{
  ssSetSampleTime(S, 0, SAMPLE_TIME_0);
  ssSetModelReferenceSampleTimeDefaultInheritance(S);
  ssSetOffsetTime(S, 0, 0.0);
}

#define MDL_INITIALIZE_CONDITIONS

/* Function: mdlInitializeConditions ========================================
 * Abstract:
 *    Initialize the states
 */
static void mdlInitializeConditions(SimStruct *S)
{
  real_T *xD = ssGetRealDiscStates(S);
  xD[0] = 1;
  xD[1] = 1;
}

#define MDL_SET_INPUT_PORT_DATA_TYPE

static void mdlSetInputPortDataType(SimStruct *S, int port, DTypeId dType)
{
  ssSetInputPortDataType(S, 0, dType);
}

#define MDL_SET_OUTPUT_PORT_DATA_TYPE

static void mdlSetOutputPortDataType(SimStruct *S, int port, DTypeId dType)
{
  ssSetOutputPortDataType(S, 0, dType);
}

#define MDL_SET_DEFAULT_PORT_DATA_TYPES

static void mdlSetDefaultPortDataTypes(SimStruct *S)
{
  ssSetInputPortDataType(S, 0, SS_DOUBLE);
  ssSetOutputPortDataType(S, 0, SS_DOUBLE);
}

#define MDL_START                                                /* Change to #undef to remove function */
#if defined(MDL_START)

/* Function: mdlStart =======================================================
 * Abstract:
 *    This function is called once at start of model execution. If you
 *    have states that should be initialized once, this is the place
 *    to do it.
 */
static void mdlStart(SimStruct *S)
{
}

#endif                                 /*  MDL_START */

/* Function: mdlOutputs =======================================================
 *
 */
static void mdlOutputs(SimStruct *S, int_T tid)
{
  const real_T *u0 = (real_T *) ssGetInputPortRealSignal(S, 0);
  real_T *y0 = (real_T *) ssGetOutputPortRealSignal(S, 0);
  const real_T *xD = ssGetDiscStates(S);
  TimeTrigger_Outputs_wrapper(u0, y0, xD, S);
}

#define MDL_UPDATE                                               /* Change to #undef to remove function */
#if defined(MDL_UPDATE)

/* Function: mdlUpdate ======================================================
 * Abstract:
 *    This function is called once for every major integration time step.
 *    Discrete states are typically updated here, but this function is
 *    useful for performing any tasks that should only take place once per
 *    integration step.
 */
static void mdlUpdate(SimStruct *S, int_T tid)
{
  const real_T *u0 = (real_T *) ssGetInputPortRealSignal(S, 0);
  real_T *y0 = (real_T *) ssGetOutputPortRealSignal(S, 0);
  real_T *xD = ssGetDiscStates(S);
  TimeTrigger_Update_wrapper(u0, y0, xD, S);
}

#endif                                 /* MDL_UPDATE */

/* Function: mdlTerminate =====================================================
 * Abstract:
 *    In this function, you should perform any actions that are necessary
 *    at the termination of a simulation.  For example, if memory was
 *    allocated in mdlStart, this is the place to free it.
 */
static void mdlTerminate(SimStruct *S)
{
}

#ifdef MATLAB_MEX_FILE                 /* Is this file being compiled as a MEX-file? */
#include "simulink.c"                  /* MEX-file interface mechanism */
#else
#include "cg_sfun.h"                   /* Code generation registration function */
#endif
