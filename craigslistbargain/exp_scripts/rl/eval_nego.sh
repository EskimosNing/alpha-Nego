EXP_NAME="eval_alpha_nego_neutral"
USE_GPU=$1
SEED="0"
if [ $# -ge 2 ]; then
  SEED=$2
fi

CHECK_POINT="checkpoint/alpha_nego_seed0_alpha0.1_policylr0_kl0_neutral/actor_seed0_940.pth"
if [ $# -ge 3 ]; then
  CHECK_POINT=$3
fi

echo "beta:"${BETA}
REWF="margin"
mkdir -p checkpoint/${EXP_NAME}
PYTHONPATH=. python craigslistbargain/multi_rl.py --schema-path craigslistbargain/data/craigslist-schema.json \
--scenarios-path craigslistbargain/data/train-scenarios.json \
--valid-scenarios-path craigslistbargain/data/dev-scenarios.json \
--price-tracker craigslistbargain/data/price_tracker.pkl \
--agent-checkpoints checkpoint/language/model_best.pt checkpoint/language/model_best.pt \
--model-path checkpoint/${EXP_NAME} --mappings mappings/language \
--optim adam  \
--agents pt-neural-dsac pt-neural-r \
--report-every 50 --max-turns 20 --num-dialogues 10000 \
--sample --temperature 0.5 --max-length 20 --reward ${REWF} \
--dia-num 20 --state-length 4 \
--model lf2lf --model-type dsac --name ${EXP_NAME} --num-cpus 1 \
--epochs 1 --gpuid ${USE_GPU} --batch-size 128 --seed ${SEED} --get-dialogues --load-type from_rl \
--actor-path ${CHECK_POINT} \
--zf1-path checkpoint/alpha_nego_seed0_alpha0.1_policylr0_kl0_neutral/zf1_seed0_940.pth \
--zf2-path checkpoint/alpha_nego_seed0_alpha0.1_policylr0_kl0_neutral/zf2_seed0_940.pth


