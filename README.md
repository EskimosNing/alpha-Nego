# alpha-Nego
alpha-Nego: Self-play Deep Reinforcement Learning for Negotiation based on Natural Language
Implements our alpha-Nego algorithms.
A more clear code with proper instruction will be available soon here. 

----------
## Installation

### Dependencies

1. Create a conda environment:

python==3.5.6, pytorch==1.1.0

```shell
conda create --name <env> --file conda_requirements.txt
```

2. pip install additional dependencies
```shell
# install other dependecies
pip install -r pip_requirements.txt
# install our code
pip install -e .
```
3. If there are some problems with the previous installation
```shell
#update pip
pip install -U pip
# install other dependecies
pip install -r pip_requirements_new.txt
# install our code
pip install -e .
```


## Traning instruction

### Preprocess
```shell
PYTHONPATH=. python core/price_tracker.py --train-examples-path data/train-luis-post-new.json --output data/price_tracker.pkl
```

### Baselines

### Train a Supervised Learning Agent
```shell
bash craigslistbargain/exp_scripts/identifier/old/train_sl.sh
```
### Train A2C Agent
Generate scenarios
```shell
PYTHONPATH=. python scripts/chat_to_scenarios.py --chats data/train-luis-post-new.json --scenarios data/train-scenarios.json
PYTHONPATH=. python scripts/chat_to_scenarios.py --chats data/dev-luis-post-new.json --scenarios data/dev-scenarios.json
```
Train the RL model 
> parameter <use_gpu>: `"--gpuid 0"` for gpu, `""` for cpu.
```shell
bash craigslistbargain/exp_scripts/rl/train_a2c.sh <exp_name> <use_gpu> <seed> <learning_rate> 
```
### Train ToM model
Sample data
```shell
bash craigslistbargain/exp_scripts/identifier/sample_data.sh <use_gpu> <seed> 
```
Implicit Model
```shell
bash craigslistbargain/exp_scripts/identifier/train_uttr_history_tom.sh <exp_name> <use_gpu>
```
Explicit Model
```shell
bash craigslistbargain/exp_scripts/identifier/train_uttr_id_history_tom.sh <exp_name> <use_gpu>
```
### Train alpha-Nego
```shell
bash craigslistbargain/exp_scripts/rl/train_nego.sh
```

### Evaluate result of different model.
> For evaluation process, gpu acceleration is unnecessary.
> 
Rule Model
```shell
bash craigslistbargain/exp_scripts/rl/eval_rule.sh
```
SL Model
```shell
bash craigslistbargain/exp_scripts/rl/eval_sl.sh
```
A2C Model
```shell
bash craigslistbargain/exp_scripts/rl/eval_rl.sh
```  
Implicit ToM Model
```shell
bash craigslistbargain/exp_scripts/rl/eval_tom_noid.sh
```
Explicit ToM Model
```shell
bash craigslistbargain/exp_scripts/rl/eval_tom.sh
```

alpha-Nego Model
```shell
bash craigslistbargain/exp_scripts/rl/eval_nego.sh
```  