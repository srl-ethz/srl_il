#!/bin/bash

python3 scripts/run_pipeline.py --config-name=diff_40

python3 scripts/run_pipeline.py --config-name=diff_40_mask

python3 scripts/run_pipeline.py --config-name=act_40_mask

python3 scripts/run_pipeline.py --config-name=act_80

python3 scripts/run_pipeline.py --config-name=diff_80


