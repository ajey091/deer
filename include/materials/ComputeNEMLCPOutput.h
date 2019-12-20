#ifndef COMPUTENEMLCPOUTPUT_H
#define COMPUTENEMLCPOUTPUT_H

#include "ComputeNEMLStressUpdate.h"
#include "EulerAngleProvider.h"

class ComputeNEMLCPOutput;

template <>
InputParameters validParams<ComputeNEMLCPOutput>();

class ComputeNEMLCPOutput: public ComputeNEMLStressUpdate
{
 public:
  ComputeNEMLCPOutput(const InputParameters & parameters);
  virtual ~ComputeNEMLCPOutput() {};

 protected:
   virtual void initQpStatefulProperties() override;

   virtual void stressUpdate(
       const double * const e_np1, const double * const e_n,
       const double * const w_np1, const double * const w_n,
       double T_np1, double T_n, double t_np1, double t_n,
       double * const s_np1, const double * const s_n,
       double * const h_np1, const double * const h_n,
       double * const A_np1, double * const B_np1,
       double & u_np1, double u_n, double & p_np1, double p_n);

   void getCPOutput(double *const h_np1, double * const s_np1, double T_np1);

 protected:
   neml::SingleCrystalModel *_cpmodel = nullptr;

   MaterialProperty<std::vector<Real>> & _orientation_q;
   MaterialProperty<RankTwoTensor> & _Fe;

   /// object providing the Euler angles
   const EulerAngleProvider * _euler;
   /// grain id
   unsigned int _grain;
   unsigned int _given = 1;

   /// Stuff for the nye tensor
   unsigned int _num_nye;
   std::vector<const VariableValue*> _nye_comps;
};


#endif // COMPUTENEMLCPOUTPUT_H