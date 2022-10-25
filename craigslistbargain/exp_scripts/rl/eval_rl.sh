EXP_NAME="eval_rl"
USE_GPU=$1
SEED="0"
BETA="1"
if [ $# -ge 2 ]; then
  SEED=$2
fi
if [ $# -ge 3 ]; then
  BETA=$3
fi
CHECK_POINT="checkpoint/a2c/model_best.pt"
if [ $# -ge 4 ]; then
  CHECK_POINT=$4
fi

echo "beta:"${BETA}

mkdir -p checkpoint/${EXP_NAME}
PYTHONPATH=. python craigslistbargain/multi_rl.py --schema-path craigslistbargain/data/craigslist-schema.json \
--scenarios-path craigslistbargain/data/train-scenarios.json \
--valid-scenarios-path craigslistbargain/data/dev-scenarios.json \
--price-tracker craigslistbargain/data/price_tracker.pkl \
--agent-checkpoints ${CHECK_POINT} checkpoint/language/model_best.pt \
--model-path checkpoint/${EXP_NAME} --mappings mappings/language \
--optim adam --tom-beta ${BETA} \
--agents pt-neural pt-neural-r \
--report-every 50 --max-turns 20 --num-dialogues 10000 \
--sample --temperature 0.5 --max-length 20 --reward margin \
--dia-num 20 --state-length 4 \
--model lf2lf --model-type a2c --name ${EXP_NAME} --num-cpus 1 \
--epochs 10 --gpuid ${USE_GPU} --batch-size 128 --seed ${SEED} --get-dialogues

