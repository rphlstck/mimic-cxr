# This script merges together all the individual labelled files
# with the original study id for each report.
# Outputs to one combined file: mimic_cxr_labeled.csv
import pandas as pd


original_path = './section_files'
labelled_path = './chexpert'

records_labelled = []
records_original = []

for i in range(23):

    print('Processing:', i)

    # Load CSVs
    records_labelled.append(
        pd.read_csv(labelled_path + '/mimic_cxr_{:02d}_labeled.csv'.format(i)).fillna(''))
    records_original.append(
        pd.read_csv(original_path + '/mimic_cxr_{:02d}.csv'.format(i), header=None).fillna(''))

    # Sanity check CSVs match
    diff = records_original[-1][1] == records_labelled[-1]['Reports']
    for idx, x in enumerate(diff.values):
        if not x:
            print('Reports diff at:', idx)
            print('Original Report:', records_original[-1].loc[idx][1])
            print('Annotated Report:', records_labelled[-1].loc[idx]['Reports'])

original = pd.concat(records_original)
labelled = pd.concat(records_labelled)

merged = pd.concat([original[0], labelled], axis=1)
merged = merged.rename(columns={0: 'Study'})

merged.to_csv('mimic_cxr_labeled.csv', index=False)

print('Done!')
