[Mesh]
  type = FileMesh
  file = 'L.exo'
[]

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

[Functions]
  [./pfn]
    type = PiecewiseLinear
    x = '0    1    2'
    y = '0.00 0.3 0.5'
  [../]
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

[BCs]
  [./left]
     type = DirichletBC
     preset = true
     variable = disp_x
     boundary = fix
     value = 0.0
  [../]

  [./bottom]
    type = DirichletBC
    preset = true
    variable = disp_y
    boundary = fix
    value = 0.0
  [../]

  [./back]
    type = DirichletBC
    preset = true
    variable = disp_z
    boundary = fix
    value = 0.0
  [../]

  [./front]
    type = FunctionDirichletBC
    variable = disp_z
    boundary = pull
    function = pfn
    preset = true
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

  petsc_options_iname = -pc_type
  petsc_options_value = lu

  nl_abs_tol = 1e-10
  nl_rel_tol = 1e-8

  end_time = 1.0
  dtmin = 0.5
  dt = 0.5
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
