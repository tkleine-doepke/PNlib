/* Linearization */
#include "PNlib.PN.Examples.ExtTest.TAwithPCtoTC_model.h"
#if defined(__cplusplus)
extern "C" {
#endif

const char *PNlib_PN_Examples_ExtTest_TAwithPCtoTC_linear_model_frame()
{
  return "model linear_PNlib_PN_Examples_ExtTest_TAwithPCtoTC\n  parameter Integer n = 3; // states\n  parameter Integer k = 0; // top-level inputs\n  parameter Integer l = 0; // top-level outputs\n"
  "  parameter Real x0[3] = {%s};\n"
  "  parameter Real u0[0] = {%s};\n"
  "  parameter Real A[3,3] = [%s];\n"
  "  parameter Real B[3,0] = zeros(3,0);%s\n"
  "  parameter Real C[0,3] = zeros(0,3);%s\n"
  "  parameter Real D[0,0] = zeros(0,0);%s\n"
  "  Real x[3](start=x0);\n"
  "  input Real u[0];\n"
  "  output Real y[0];\n"
  "\n  Real 'x_P1.t_' = x[1];\nReal 'x_P2.t_' = x[2];\nReal 'x_P3.t_' = x[3];\n\n"
  "equation\n  der(x) = A * x + B * u;\n  y = C * x + D * u;\nend linear_PNlib_PN_Examples_ExtTest_TAwithPCtoTC;\n";
}
const char *PNlib_PN_Examples_ExtTest_TAwithPCtoTC_linear_model_datarecovery_frame()
{
  return "model linear_PNlib_PN_Examples_ExtTest_TAwithPCtoTC\n  parameter Integer n = 3; // states\n  parameter Integer k = 0; // top-level inputs\n  parameter Integer l = 0; // top-level outputs\n  parameter Integer nz = 51; // data recovery variables\n"
  "  parameter Real x0[3] = {%s};\n"
  "  parameter Real u0[0] = {%s};\n"
  "  parameter Real z0[51] = {%s};\n"
  "  parameter Real A[3,3] = [%s];\n"
  "  parameter Real B[3,0] = zeros(3,0);%s\n"
  "  parameter Real C[0,3] = zeros(0,3);%s\n"
  "  parameter Real D[0,0] = zeros(0,0);%s\n"
  "  parameter Real Cz[51,3] = [%s];\n"
  "  parameter Real Dz[51,0] = zeros(51,0);%s\n"
  "  Real x[3](start=x0);\n"
  "  input Real u[0];\n"
  "  output Real y[0];\n"
  "  output Real z[51];\n"
  "\nReal 'x_P1.t_' = x[1];\nReal 'x_P2.t_' = x[2];\nReal 'x_P3.t_' = x[3];\nReal 'z_$cse1' = z[1];\nReal 'z_$cse2' = z[2];\nReal 'z_EA1.tIn' = z[3];\nReal 'z_P1.conMarkChange' = z[4];\nReal 'z_P1.decFactorOut2[1].value' = z[5];\nReal 'z_P1.disMarkChange' = z[6];\nReal 'z_P1.firingSum3Dis.value' = z[7];\nReal 'z_P1.firingSum4Dis.value' = z[8];\nReal 'z_P1.firingSumInCon.conFiringSum' = z[9];\nReal 'z_P2.conMarkChange' = z[10];\nReal 'z_P2.decFactorIn2[1].value' = z[11];\nReal 'z_P2.disMarkChange' = z[12];\nReal 'z_P2.firingSum3Dis.value' = z[13];\nReal 'z_P2.firingSum4Dis.value' = z[14];\nReal 'z_P2.firingSumOutCon.conFiringSum' = z[15];\nReal 'z_P2.t' = z[16];\nReal 'z_P3.conMarkChange' = z[17];\nReal 'z_P3.decFactorIn2[1].value' = z[18];\nReal 'z_P3.disMarkChange' = z[19];\nReal 'z_P3.firingSum3Dis.value' = z[20];\nReal 'z_P3.firingSum4Dis.value' = z[21];\nReal 'z_P3.firingSumOutCon.conFiringSum' = z[22];\nReal 'z_P3.t' = z[23];\nReal 'z_T1.actualSpeed' = z[24];\nReal 'z_T1.arcWeightInCon[1]' = z[25];\nReal 'z_T1.arcWeightOutCon[1]' = z[26];\nReal 'z_T1.conActivation.arcWeightIn[1]' = z[27];\nReal 'z_T1.conActivation.maxTokens[1]' = z[28];\nReal 'z_T1.conActivation.minTokens[1]' = z[29];\nReal 'z_T1.conActivation.tIn[1]' = z[30];\nReal 'z_T1.conActivation.tOut[1]' = z[31];\nReal 'z_T1.instantaneousSpeed' = z[32];\nReal 'z_T1.maximumSpeed' = z[33];\nReal 'z_T1.prelimSpeed.arcWeight' = z[34];\nReal 'z_T1.prelimSpeed.arcWeightIn[1]' = z[35];\nReal 'z_T1.prelimSpeed.arcWeightOut[1]' = z[36];\nReal 'z_T1.prelimSpeed.prelimSpeed' = z[37];\nReal 'z_T1.prelimSpeed.speedSum' = z[38];\nReal 'z_T1.prelimSpeed.speedSumIn[1]' = z[39];\nReal 'z_T1.prelimSpeed.speedSumOut[1]' = z[40];\nReal 'z_T2.actualSpeed' = z[41];\nReal 'z_T2.arcWeightOutCon[1]' = z[42];\nReal 'z_T2.conActivation.maxTokens[1]' = z[43];\nReal 'z_T2.conActivation.tOut[1]' = z[44];\nReal 'z_T2.instantaneousSpeed' = z[45];\nReal 'z_T2.maximumSpeed' = z[46];\nReal 'z_T2.prelimSpeed.arcWeight' = z[47];\nReal 'z_T2.prelimSpeed.arcWeightOut[1]' = z[48];\nReal 'z_T2.prelimSpeed.prelimSpeed' = z[49];\nReal 'z_T2.prelimSpeed.speedSum' = z[50];\nReal 'z_T2.prelimSpeed.speedSumOut[1]' = z[51];\n\n"
  "equation\n  der(x) = A * x + B * u;\n  y = C * x + D * u;\n  z = Cz * x + Dz * u;\nend linear_PNlib_PN_Examples_ExtTest_TAwithPCtoTC;\n";
}
#if defined(__cplusplus)
}
#endif

