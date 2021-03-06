//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "CZMMaterialBasePK1.h"

/**
 * Implementation of the non-stateful exponential traction separation law
 * proposed by Salehani, Mohsen Khajeh and Irani, Nilgoon 2018
 **/
class PureElasticCZMIncremental : public CZMMaterialBasePK1 {
public:
  static InputParameters validParams();
  PureElasticCZMIncremental(const InputParameters &parameters);

protected:
  virtual void computeTractionIncrementAndDerivatives() override;

  const RankTwoTensor _K;
};
