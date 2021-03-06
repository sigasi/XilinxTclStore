#########################################################################
#
# register_options.tcl (create simulation fileset properties with default
#                       values for the 'Cadence IES Simulator')
#
# Script created on 01/06/2014 by Raj Klair (Xilinx, Inc.)
#
# 2014.1 - v1.0 (rev 1)
#  * initial version
#
#########################################################################
package require Vivado 1.2014.1
package require ::tclapp::xilinx::ies::helpers

namespace eval ::tclapp::xilinx::ies {
proc register_options { simulator } {
  # Summary: define simulation fileset options
  # Argument Usage:
  # simulator: name of the simulator for which the options needs to be defined
  # Return Value:
  # true (0) if success, false (1) otherwise

  variable options
  if { {} == $simulator } {
    send_msg_id Vivado-IES-001 ERROR "Simulator not specified.\n"
  }
  # is simulator registered?
  if { {-1} == [lsearch [get_simulators] $simulator] } {
    send_msg_id Vivado-IES-002 ERROR "Simulator '$simulator' is not registered\n"
    return 1
  }
  set options {
    {{compile.v93}                   {bool}   {1}        {Enable VHDL93 features}}
    {{compile.32bit}                 {bool}   {0}        {Invoke 32-bit executable}}
    {{compile.relax}                 {bool}   {1}        {Enable relaxed VHDL interpretation}}
    {{compile.unifast}               {bool}   {0}        {Enable fast simulation models}}
    {{compile.load_glbl}             {bool}   {1}        {Load GLBL module}}
    {{compile.ncvhdl.more_options}   {string} {}         {More NCVHDL compilation options}}
    {{compile.ncvlog.more_options}   {string} {}         {More NCVLOG compilation options}}
    {{elaborate.ncelab.more_options} {string} {}         {More NCELAB elaboration options}}
    {{simulate.runtime}              {string} {1000ns}   {Specify simulation run time}}
    {{simulate.uut}                  {string} {}         {Specify instance name for design under test (default:/uut)}}
    {{simulate.saif}                 {string} {}         {SAIF filename}}
    {{simulate.ncsim.more_options}   {string} {}         {More NCSIM simulation options}}
  }
  # create options
  ::tclapp::xilinx::ies::usf_create_options $simulator $options
  return 0
}
}
