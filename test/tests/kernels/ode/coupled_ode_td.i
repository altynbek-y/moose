[Mesh]
  type = GeneratedMesh
  dim = 1
  xmin = 0
  xmax = 1
  nx = 1
[]


[Variables]
  [./f]
    family = SCALAR
    order = FIRST
    initial_condition = 1
  [../]
  [./f_times_mult]
    family = SCALAR
    order = FIRST
    initial_condition = 1
  [../]
[]

[ScalarKernels]
  [./dT]
    type = CoupledODETimeDerivative
    variable = f
    v = f_times_mult
  [../]

  [./src]
    type = ParsedODEKernel
    variable = f
    function = '-1'
  [../]

  [./f_times_mult_1]
    type = ParsedODEKernel
    variable = f_times_mult
    function = 'f_times_mult'
  [../]

  [./f_times_mult_2]
    type = ParsedODEKernel
    variable = f_times_mult
    function = '-f * g'
    args = 'f g'
  [../]
[]

[AuxVariables]
  [./g]
    family = SCALAR
    order = FIRST
  [../]
[]

[Functions]
  [./function_g]
    type = ParsedFunction
    value = '(1 + t)'
  [../]
[]

[AuxScalarKernels]
  [./set_g]
    type = FunctionScalarAux
    function = function_g
    variable = g
    execute_on = 'linear initial'
  [../]
[]

[Executioner]
  type = Transient
  dt = 1
  num_steps = 3
  nl_abs_tol = 1e-9
[]

[Outputs]
  csv = true
[]
