# Loads environment variables from .env for local development.
#
# Notes:
# - GitHub Pages builds run in safe mode and ignore custom plugins.
# - Keep secrets in .env (gitignored).

begin
  require "dotenv"
  Dotenv.load

  placeholder_patterns = [
    /^YOUR_NEW_TOKEN_HERE$/,
    /^ghp_your_token_here$/,
    /^github_pat_/, # don't allow accidentally committed/pasted PATs to be used implicitly
  ]

  ["JEKYLL_GITHUB_TOKEN", "GITHUB_TOKEN"].each do |key|
    value = ENV[key]
    next if value.nil? || value.strip.empty?
    if placeholder_patterns.any? { |pattern| pattern.match?(value.strip) }
      ENV.delete(key)
    end
  end
rescue LoadError
  # If dotenv isn't installed, just skip loading.
end
