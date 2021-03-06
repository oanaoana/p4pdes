include ${PETSC_DIR}/lib/petsc/conf/variables
include ${PETSC_DIR}/lib/petsc/conf/rules

ode: ode.o  chkopts
	-${CLINKER} -o ode ode.o  ${PETSC_LIB}
	${RM} ode.o

odejac: odejac.o  chkopts
	-${CLINKER} -o odejac odejac.o  ${PETSC_LIB}
	${RM} odejac.o

heat: heat.o  chkopts
	-${CLINKER} -o heat heat.o  ${PETSC_LIB}
	${RM} heat.o

pattern: pattern.o  chkopts
	-${CLINKER} -o pattern pattern.o  ${PETSC_LIB}
	${RM} pattern.o


# testing
runode_1:
	-@../testit.sh ode "-ts_init_time 19.0 -ts_dt 0.01 -ts_max_time 20.0" 1 1

runode_2:
	-@../testit.sh ode "-ts_type cn -snes_fd -ts_max_time 1.0" 1 2

runode_3:
	-@../testit.sh ode "-ts_monitor -ts_max_time 1.0" 1 3

runodejac_1:
	-@../testit.sh odejac "-ts_max_time 1.0" 1 1

runodejac_2:
	-@../testit.sh odejac "-ts_monitor -ts_max_time 1.0 -ts_type rk" 1 2

runheat_1:
	-@../testit.sh heat "-da_refine 1 -ts_monitor" 1 1

runheat_2:
	-@../testit.sh heat "-da_refine 2 -ht_monitor" 2 2

runheat_3:
	-@../testit.sh heat "-da_refine 1 -ts_monitor -ts_type rk -ts_max_time 0.01" 1 3

runpattern_1:
	-@../testit.sh pattern "-da_refine 2 -ts_monitor" 1 1   # refinement of 1 misses initial condition

# why does GMG work for pattern but not heat?  (GMG really is working; add -mg_{coarse,levels}_ksp_converged_reason)
runpattern_2:
	-@../testit.sh pattern "-da_refine 2 -ts_monitor -ts_dt 1 -ts_max_time 1 -ts_type beuler -pc_type mg -snes_converged_reason -ksp_converged_reason -snes_rtol 1.0e-1" 1 2

test_ode: runode_1 runode_2 runode_3

test_odejac: runodejac_1 runodejac_2

test_heat: runheat_1 runheat_2 runheat_3

test_pattern: runpattern_1 runpattern_2

test: test_ode test_odejac test_heat test_pattern

# etc

.PHONY: distclean runode_1 runode_2 runode_3 runodejac_1 runheat_1 runheat_2 runpattern_1 test test_ode test_odejac test_heat test_pattern

distclean:
	@rm -f *~ ode odejac heat pattern *tmp
	@rm -f *.pyc *.dat *.dat.info *.png PetscBinaryIO.py petsc_conf.py

