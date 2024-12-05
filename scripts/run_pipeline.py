import sys
# use line-buffering for both stdout and stderr. TODO: check if this is necessary
sys.stdout = open(sys.stdout.fileno(), mode='w', buffering=1)
sys.stderr = open(sys.stderr.fileno(), mode='w', buffering=1)

import hydra
from omegaconf import OmegaConf
import pathlib
import torch
import wandb
from pathlib import Path
import os

# allows arbitrary python code execution in configs using the ${eval:''} resolver
OmegaConf.register_new_resolver("eval", eval, replace=True)

@hydra.main(
    version_base=None,
    # config_path=str(pathlib.Path(__file__).parent.parent.joinpath('srl_il','cfg'))
    config_path=str(pathlib.Path(__file__).parent.parent.joinpath('srl_il','cfg/orca/ACT'))
)
def main(cfg: OmegaConf):
    # resolve immediately so all the ${now:} resolvers
    # will use the same time.
    OmegaConf.resolve(cfg)

    if not os.path.exists(cfg["dataset_cfg"]["data"]["data_directory"]):
        raise FileNotFoundError(f"(In IL YAML file) Data directory {cfg['dataset_cfg']['data']['data_directory']} does not exist")

    # create the pipeline
    pipeline_cls = hydra.utils.get_class(cfg.pipeline._target_)

    pipeline = pipeline_cls(**cfg)
    pipeline.run()

if __name__ == "__main__":
    main()
