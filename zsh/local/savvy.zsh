# ------------------------------------------------------------------------------
# SavvyCal Workflow
# ------------------------------------------------------------------------------

lin() {
  if [[ "$OSTYPE" == "linux"* ]]; then
    xdg-open https://linear.app/savvycal/issue/$(current_linear_issue)
  else
    open linear://linear.app/savvycal/issue/$(current_linear_issue)
  fi
}
