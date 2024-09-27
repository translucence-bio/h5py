import json
from pathlib import Path

from auditwheel import policy


policies_dir = Path(policy.__file__).parent


def remove_zlib_from_whitelist():

    for fpath in policies_dir.glob('*-policy.json'):
        with fpath.open('r') as fh:
            policies = json.load(fh)

        for policy in policies:
            lib_whitelist = policy['lib_whitelist']

            if 'libz.so.1' in lib_whitelist:
                lib_whitelist.remove('libz.so.1')

        with fpath.open('w') as fh:
            fh.write(json.dumps(policies))


if __name__ == '__main__':
    remove_zlib_from_whitelist()
