#! /bin/sh

################################################################################

# files to compare for the test

files="\
	*.in \
	EFERMI.OUT EIGVAL.OUT EQATOMS.OUT EVALCORE.OUT FERMIDOS.OUT GEOMETRY.OUT \
	IADIST.OUT INFO.OUT KPOINTS.OUT LATTICE.OUT LINENGY.OUT RMSDVEFF.OUT \
	SYMCRYS.OUT SYMLAT.OUT SYMSITE.OUT TOTENERGY.OUT \
	\
	BAND*.OUT \
	\
	PARAMS*.OUT XSINFO.OUT TIME.OUT \
	SYMGENR.OUT SYMINV.OUT SYMMULT.OUT SYMMULT_TABLE.OUT SYMT2.OUT \
	GQPOINTS_*.OUT KMAPKQ_*.OUT QPOINTS*.OUT \
	EIGVAL_*.OUT EFERMI_*.OUT \
	SCREEN_*.OUT W_SCREEN_*.OUT DIELTENS_*.OUT \
	FXC_BSE_HEAD*.OUT \
	EXCLI_ASC.OUT SCCLI_ASC.OUT BSEDIAG.OUT \
	EXCITON_*.OUT EPSILON_*.OUT LOSS_*.OUT SIGMA_*.OUT SUMRULES_*.OUT \
"

################################################################################


rundir="_current"
diffdir="_diff.reference_current"

echo
echo "Running test..."
echo

\cp -f exciting.in_ exciting.in

../../bin/excitingser

\rm -fr $rundir
\rm -fr $diffdir
\mkdir $rundir
\mkdir $diffdir

\cp -f $files $rundir

for file in $files; do
	diff -B -w _reference/$file $rundir/$file > $diffdir/$file.diff
	#diff -r -B -w _reference $rundir > reference_current.diff

done

echo "done."
echo
