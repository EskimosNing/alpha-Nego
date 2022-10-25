GPU_ID="0"
SEED="0"
if [ $# -ge 2 ]; then
  SEED=$2
fi
ALPHA=0.1
if [ $# -ge 3 ]; then
  ALPHA=$3
fi
POLICY_LR=0.0001
if [ $# -ge 4 ]; then
  POLICY_LR=$4
fi
KL=0
if [ $# -ge 5 ]; then
  KL=$5
fi
REWF=margin

EXP_NAME=alpha_nego_seed${SEED}_alpha${ALPHA}_policylr${POLICY_LR}_kl${KL}_neutral
echo ${EXP_NAME}

mkdir -p checkpoint/${EXP_NAME}
mkdir cache
PYTHONPATH=. python craigslistbargain/multi_rl.py --schema-path craigslistbargain/data/craigslist-schema.json \
--scenarios-path craigslistbargain/data/train-scenarios.json \
--valid-scenarios-path craigslistbargain/data/dev-scenarios.json \
--price-tracker craigslistbargain/data/price_tracker.pkl \
--agent-checkpoints checkpoint/language/model_best.pt checkpoint/language/model_best.pt \
--model-path checkpoint/${EXP_NAME} --mappings mappings/language \
--optim adam --learning-rate 0.001 \
--agents pt-neural-dsac pt-neural-r \
--report-every 50 --max-turns 20 --num-dialogues 10000 \
--sample --temperature 0.5 --max-length 20 --reward ${REWF} \
--dia-num 20 --state-length 4 \
--model lf2lf --model-type dsac --name ${EXP_NAME} --num-cpus 1 \
--epochs 1200 --gpuid ${USE_GPU} --batch-size 128 --seed ${SEED} --load-type from_sl  \
--zf-lr 0.0003 --common-lr ${POLICY_LR} --intent-lr ${POLICY_LR} --price-lr 0.0001 --alpha ${ALPHA} \
--replay-buffer 20000  --kl-coefficient ${KL} --self-play
