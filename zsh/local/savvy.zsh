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

savci() {
  local results=()

  echo '\nRunning turbo lint...\n'
  if in assets npx turbo lint; then results+=('✅ turbo lint'); else results+=('❌ turbo lint'); fi

  echo '\nRunning mix credo...\n'
  if mix credo; then results+=('✅ mix credo'); else results+=('❌ mix credo'); fi

  echo '\nRunning mix test...\n'
  if mix test; then results+=('✅ mix test'); else results+=('❌ mix test'); fi

  echo '\nSummary:\n--------'
  for result in "${results[@]}"; do
    echo $result
  done
}
