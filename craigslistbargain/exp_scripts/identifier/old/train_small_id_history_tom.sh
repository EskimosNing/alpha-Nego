EXP_NAME="small_id_history_tom"
MODEL_NAME="id_history_tom"
USE_GPU=$1

mkdir -p checkpoint/${EXP_NAME}
PYTHONPATH=. python craigslistbargain/multi_rl.py --schema-path craigslistbargain/data/craigslist-schema.json \
--scenarios-path craigslistbargain/data/train-scenarios.json \
--valid-scenarios-path craigslistbargain/data/dev-scenarios.json \
--price-tracker craigslistbargain/data/price_tracker.pkl \
--agent-checkpoints checkpoint/language/model_best.pt checkpoint/language/model_best.pt \
--model-path checkpoint/${EXP_NAME} --mappings mappings/language \
--optim adam --rnn-type RNN --rnn-size 300 --max-grad-norm -1 \
--agents pt-neural pt-neural-r \
--report-every 50 --max-turns 20 --num-dialogues 2560 \
--sample --temperature 0.5 --max-length 20 --reward margin \
--dia-num 20 --state-length 4 --epochs 2000 --use-utterance \
--model lf2lf --model-type a2c --tom-test --load-sample cache/hard_pmask/data.pkl \
--learning-rate 0.001 --name ${EXP_NAME} \
--tom-hidden-size 512 --tom-hidden-depth 3 --id-hidden-size 32 --id-hidden-depth 1 \
--tom-model ${MODEL_NAME} ${USE_GPU}
