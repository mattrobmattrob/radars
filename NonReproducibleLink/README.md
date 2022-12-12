## <rdar://FB11870191>

Summary:

With ld it's possible to get non-deterministic behavior where the
`__objc_methname` section's contents are in different orders. Attached is a
repro case. Run `./repro.sh` to experience it. Sometimes it takes multiple
runs to hit. The gist of the project is that it links the OHHTTPStubs binary
(`libOHHTTPStubs_objc.a`).

Steps to Reproduce:

Run `./repro.sh`

Expected Results:

The binaries should never differ since we're setting `ZERO_AR_DATE` and
providing the same inputs every time.

Actual Results:

The binaries differ in a very reproducible way.

Environment:

Xcode 14.1 and 14.0.1 (likely others)
