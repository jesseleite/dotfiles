# ------------------------------------------------------------------------------
# SavvyCal Workflow
# ------------------------------------------------------------------------------

savl() {
  if [[ "$OSTYPE" == "linux"* ]]; then
    xdg-open https://linear.app/savvycal/issue/$(current_linear_issue)
  else
    open linear://linear.app/savvycal/issue/$(current_linear_issue)
  fi
}

savci() {(
  local results=()

  echo '\nRunning turbo lint...\n'
  if in assets npx turbo lint; then results+=('✅ turbo lint'); else results+=('❌ turbo lint'); fi

  echo '\nRunning mix credo...\n'
  if mix credo; then results+=('✅ mix credo'); else results+=('❌ mix credo'); fi

  echo '\nRunning mix dialyzer...\n'
  if mix dialyzer; then results+=('✅ mix dialyzer'); else results+=('❌ mix dialyzer'); fi

  echo '\nRunning mix test...\n'
  if mix test; then results+=('✅ mix test'); else results+=('❌ mix test'); fi

  echo '\nSummary:\n--------'
  for result in "${results[@]}"; do
    echo $result
  done
)}

savrnd() {
  local for_friday previous_friday
  local day_of_week=$(date +%u)

  if (( day_of_week == 5 )); then
    for_friday=$(date +%m-%d)
    previous_friday=$(date -v-7d +%m-%d)
  else
    local days_since_friday=$(( (day_of_week + 2) % 7 ))
    if (( days_since_friday == 0 )); then
      days_since_friday=7
    fi
    for_friday=$(date -v-${days_since_friday}d +%m-%d)
    previous_friday=$(date -v-$(( days_since_friday + 7 ))d +%m-%d)
  fi

  local rnd_prompt=$(sed -e "s/{{previous_friday}}/${previous_friday}/g" \
                         -e "s/{{for_friday}}/${for_friday}/g" \
                         "${DOTFILES}/robots/templates/savvy/rnd.md")

  opencode --prompt "${rnd_prompt}"
}
