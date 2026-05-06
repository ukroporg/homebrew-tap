.PHONY: help update update-ukrop audit

help:
	@echo "Targets:"
	@echo "  update        Update all formulae to their latest upstream tags"
	@echo "  update-ukrop  Update Formula/ukrop.rb to the latest ukroporg/ukrop tag"
	@echo "  audit         Run 'brew audit --strict' on all formulae"

update: update-ukrop

update-ukrop:
	@./scripts/update-ukrop.sh

audit:
	@brew audit --strict --formula Formula/*.rb
