# Fails if any internal link, image, or in-page anchor in the built site is broken.
# Absolute links to this site are treated as internal so they are checked too.
require "html-proofer"

HTMLProofer.check_directory(
  ARGV.fetch(0, "_site"),
  disable_external: true,
  checks: %w[Links Images Scripts],
  allow_missing_href: true,
  ignore_missing_alt: true,
  ignore_empty_alt: true,
  enforce_https: false,
  swap_urls: { %r{\Ahttps?://mattgeorgephd\.github\.io} => "" }
).run
