dest="/lustre/scratch/epp/neutrino/snoplus/echidna_env27/bash_scripts/tmp"
base="/lustre/scratch/epp/neutrino/snoplus/production/share/5.0.2/"
for x in  $(find $base | grep "mc_sum.hdf5$");do
if [[ $x == *"Summed/"* ]]
then
    continue;
fi
bg_dir=`dirname $x`; 
for i in `seq 180 220`; do
cat <<EOT > $dest/${x##*/}_smear${i}ly.sh
#$ -S /bin/bash
#$ -o /lustre/scratch/epp/neutrino/snoplus/echidna_env27/bash_scripts/logs
#$ -e /lustre/scratch/epp/neutrino/snoplus/echidna_env27/bash_scripts/logs
#$ -q mps.q

source  /lustre/scratch/epp/neutrino/snoplus/rat/snoing/install/env_rat-5.0.3.sh
cd /lustre/scratch/epp/neutrino/snoplus/echidna_env27/
source bin/activate
cd ../echidna
export PYTHONPATH=\$(pwd):\$PYTHONPATH

python echidna/scripts/dump_smeared_energy.py $x -l $i -d ${bg_dir}/energy_mc/smear/;
EOT
#qsub $dest/${x##*/}_smear${i}ly.sh
done
done
