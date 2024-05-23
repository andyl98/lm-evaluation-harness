#!/bin/bash

models=(
  "masakhane/African-ultrachat-alpaca"
  "masakhane/zephyr-7b-gemma-sft-african-alpaca"
  "masakhane/zephyr-7b-gemma-sft-african-ultrachat-5k"
  "google/flan-t5-xxl"
  "bigscience/mt0-xxl-mt"
  "CohereForAI/aya-101"
  "bigscience/bloomz-7b1-mt"
  "meta-llama/Llama-2-7b-chat-hf"
  "meta-llama/Meta-Llama-3-8B-Instruct"
  "meta-llama/Meta-Llama-3-70B-Instruct"
  "google/gemma-1.1-7b-it"
  "RWKV/v5-EagleX-v2-7B-HF"
  "RWKV/rwkv-6-world-7b"
)
task=afrixnli_en_direct_amh,afrixnli_en_direct_eng,afrixnli_en_direct_ewe,afrixnli_en_direct_fra,afrixnli_en_direct_hau,afrixnli_en_direct_ibo,afrixnli_en_direct_kin,afrixnli_en_direct_lin,afrixnli_en_direct_lug,afrixnli_en_direct_orm,afrixnli_en_direct_sna,afrixnli_en_direct_sot,afrixnli_en_direct_swa,afrixnli_en_direct_twi,afrixnli_en_direct_wol,afrixnli_en_direct_xho,afrixnli_en_direct_yor,afrixnli_en_direct_zul

for model in "${models[@]}"
do
  echo "Evaluating model: $model"
  for fewshot in 0 2 4 6 8
  do
    export OUTPUT_DIR=results/${model##*/}/$fewshot

    mkdir -p "$OUTPUT_DIR"

    lm_eval --model hf \
            --model_args "pretrained=${model}" \
            --tasks $task\
            --device cuda:0 \
            --batch_size 16 \
            --output_path "$OUTPUT_DIR" \
            --num_fewshot $fewshot \
            --verbosity DEBUG
  done
done