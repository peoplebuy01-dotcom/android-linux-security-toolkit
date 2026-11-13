# Quality Assurance Checklist

Before every release:

- [ ] Internal Markdown links resolve.
- [ ] External links point to official project sources and are reviewed.
- [ ] Every shell script passes `bash -n`.
- [ ] Scripts run without root where possible.
- [ ] No script deletes data, changes security settings, or sends telemetry by default.
- [ ] No tokens, passwords, private keys, serials, or personal logs are committed.
- [ ] Command risk levels and expected output are documented.
- [ ] Android instructions are tested on a supported test device or clearly marked untested.
- [ ] Tool installation steps match current official docs.
- [ ] Safety boundaries are clear for scanners, proxies, instrumentation, and reverse engineering.
- [ ] README and docs index reflect the current file tree.
- [ ] Changelog records user-visible changes.

## Local checks

```bash
for f in scripts/*.sh; do bash -n "$f" || exit 1; done
```

For link checking, use a trusted Markdown link checker installed from its official source. Network checks can fail due to rate limits, redirects, or temporary outages; review failures manually before release.

## Release discipline

Use semantic versions. Do not label a release production-ready until scripts and instructions have been tested on their stated platforms. Record untested areas honestly.
