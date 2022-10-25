USE_GPU=$1
SEED="0"
if [ $# -ge 2 ]; then
  SEED=$2
fi
EXP_NAME="hard_pmask_7_"${SEED}
# tom_itentity_test
mkdir -p checkpoint/${EXP_NAME}
PYTHONPATH=. python craigslistbargain/multi_rl.py --schema-path craigslistbargain/data/craigslist-schema.json \
--scenarios-path craigslistbargain/data/train-scenarios.json \
--valid-scenarios-path craigslistbargain/data/dev-scenarios.json \
--price-tracker craigslistbargain/data/price_tracker.pkl \
--agent-checkpoints checkpoint/language/model_best.pt checkpoint/language/model_best.pt \
--model-path checkpoint/hard_pmask --mappings mappings/language \
--optim adam --rnn-type RNN --rnn-size 300 --max-grad-norm -1 \
--agents pt-neural pt-neural-r \
--report-every 50 --max-turns 20 --num-dialogues 8960 \
--sample --temperature 0.5 --max-length 20 --reward margin \
--dia-num 20 --state-length 4 --epochs 2 --use-utterance \
--model lf2lf --model-type a2c --tom-test --seed ${SEED} \
--learning-rate 0.001 --name ${EXP_NAME} --tom-hidden-size 128 --hidden-depth 1 ${USE_GPU}