.PHONY: backup restore

backup:
	find ./* -mindepth 1 -path '*/.*' -prune -o -type f ! -name "*.bak" -exec bash -c 'for f; do mv -- "$$f" "$${f}.bak"; done' bash {} +

restore:
	find ./* -mindepth 1 -path '*/.*' -prune -o -type f -name "*.bak" -exec bash -c 'for f; do mv -- "$$f" "$${f%.bak}"; done' bash {} +
