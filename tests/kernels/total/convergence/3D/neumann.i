# Simple 3D test

[GlobalParams]
  displacements = 'disp_x disp_y disp_z'
  large_kinematics = true
[]

[Variables]
      [./disp_x]
      [../]
      [./disp_y]
      [../]
      [./disp_z]
      [../]
[]

[Mesh]
  [./msh]
    type = GeneratedMeshGenerator
    dim = 3
    nx = 4
    ny = 4
    nz = 4
  []
[]

[Kernels]
  [./sdx]
      type = TotalStressDivergenceNEML
      variable = disp_x
      component = 0
  [../]
  [./sdy]
      type = TotalStressDivergenceNEML
      variable = disp_y
      component = 1
  [../]
  [./sdz]
      type = TotalStressDivergenceNEML
      variable = disp_z
      component = 2
  [../]
[]

[Functions]
  [./pullx]
    type = ParsedFunction
    value ='4000 * t'
  [../]
  [./pully]
    type = ParsedFunction
    value ='-2000 * t'
  [../]
  [./pullz]
    type = ParsedFunction
    value ='3000 * t'
  [../]
[]

[BCs]
  [./leftx]
    type = DirichletBC
    preset = true
    boundary = left
    variable = disp_x
    value = 0.0
  [../]
  [./lefty]
    type = DirichletBC
    preset = true
    boundary = left
    variable = disp_y
    value = 0.0
  [../]
  [./leftz]
    type = DirichletBC
    preset = true
    boundary = left
    variable = disp_z
    value = 0.0
  [../]
  [./pull_x]
    type = FunctionNeumannBC
    boundary = right
    variable = disp_x
    function = pullx
  [../]
  [./pull_y]
    type = FunctionNeumannBC
    boundary = top
    variable = disp_y
    function = pully
  [../]
  [./pull_z]
    type = FunctionNeumannBC
    boundary = right
    variable = disp_z
    function = pullz
  [../]
[]

[Materials]
  [./strain]
    type = ComputeNEMLStrain
  [../]
  [./stress]
    type = ComputeNEMLStressUpdate
    database = "test.xml"
    model = "elastic_model"
  [../]
[]

[Preconditioning]
  [./smp]
    type = SMP
    full = true
  [../]
[]

[Executioner]
  type = Transient

  solve_type = 'newton'
  line_search = none

  petsc_options_iname = '-pc_type'
  petsc_options_value = 'lu'

  l_max_its = 2
  l_tol = 1e-14
  nl_max_its = 15
  nl_rel_tol = 1e-8
  nl_abs_tol = 1e-10

  start_time = 0.0
  dt = 0.2
  dtmin = 0.2
  end_time = 1.0
[]

[Postprocessors]
  [./nonlin]
    type = NumNonlinearIterations
  [../]
[]

[Outputs]
  exodus = false
  csv = true
[]
