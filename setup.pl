#! /usr/bin/perl
# setupscript
# setupscript for the exciting code
print "---------------------------------------------------------\n";

opendir(PDIR, "build/platforms") || die("Cannot open directory");
@makeincfiles= sort(readdir(PDIR));

$count=1;
#print @makeincfiles;

@fileslist=[];
foreach $file (@makeincfiles){
 	$platform="";
	if($file=~ m/make\.inc\.(.+$)/) 
	{ $platform=$1;
	   print $count." ".$platform;
	   print ("\n");
	   $count++;
	   push(@fileslist,$file);
	   if ($count%20==0) {
		   print "type enter for more";
		   $wait=<>;
	   }
	}
}
print "\nEnter the number of the platform that suites your system best:  ";
$sel=<>;

if ($sel>$count-1 || $sel<1 || $sel=~m/^$/ || $sel!~m/^\d+$/) {
	print "\ntry again\n\n";
	exit;
}else{

print "\nYou use the makefile from:\n\n build/platforms/" . @fileslist[$sel];
print "\n\nIf the compilation fails, edit \"build/make.inc\" and execute \"make\" again.\n"
}

$filename="build/platforms/" . @fileslist[$sel];

@args=("cp",$filename,"build/make.inc");
$return= system(@args);

$selected=0;
while($selected==0){
	print "\nIf you have MPI installed you can build exciting with k-point parallelization support.\n\n";
	print "Build MPI binary ? (yes/No)  ";
	$MPI=<>;
	if($MPI=~m/yes/i){
		$selected=1;
		system("echo \"BUILDMPI=true\">>build/make.inc"); 

	}elsif($MPI=~m/no/i) {
		system("echo \"BUILDMPI=false\">>build/make.inc");
		$selected=1;
	}else{
		print "please chose yes or no";
		$selected=0;
	}
}

$selected=0;
while($selected==0){
print "\nIf you have multithreaded BLAS/LAPACK installed you can build exciting with SMP support.\n\n";
print "Build SMP lib binary (yes/No)  ";
$SMP=<>;
if($SMP=~m/yes/i){
	system("echo \"BUILDSMP=true\">>build/make.inc");
		$selected=1;
}elsif ($SMP=~m/no/i)
{
	system("echo \"BUILDSMP=false\" >>build/make.inc");
		$selected=1;
}else{
	print "please chose yes or no";
		
}
}

