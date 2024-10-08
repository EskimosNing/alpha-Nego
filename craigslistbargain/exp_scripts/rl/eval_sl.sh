EXP_NAME="eval_sl"$1
USE_GPU=$2
SEED="0"
BETA="1"
if [ $# -ge 3 ]; then
  SEED=$3
fi
if [ $# -ge 4 ]; then
  BETA=$4
fi
CHECK_POINT="checkpoint/language/model_best.pt"
if [ $# -ge 5 ]; then
  CHECK_POINT=$5
fi
#TOM_CHECK_POINT="--load-identity-from checkpoint/uttr_id_tom_history_7_4/model_best.pt"

echo "beta:"${BETA}

mkdir -p checkpoint/${EXP_NAME}
PYTHONPATH=. python craigslistbargain/multi_rl.py --schema-path craigslistbargain/data/craigslist-schema.json \
--scenarios-path craigslistbargain/data/train-scenarios.json \
--valid-scenarios-path craigslistbargain/data/dev-scenarios.json \
--price-tracker craigslistbargain/data/price_tracker.pkl \
--agent-checkpoints checkpoint/language/model_best.pt checkpoint/language/model_best.pt \
--model-path checkpoint/${EXP_NAME} --mappings mappings/language \
--optim adam --tom-beta ${BETA} \
--agents pt-neural-s pt-neural-r \
--report-every 50 --max-turns 20 --num-dialogues 10000 \
--sample --temperature 0.5 --max-length 20 --reward margin \
--dia-num 20 --state-length 4 \
--model lf2lf --model-type a2c --name ${EXP_NAME} --num-cpus 5 \
--epochs 10 --gpuid ${USE_GPU} --batch-size 128 --seed ${SEED} --get-dialogues

