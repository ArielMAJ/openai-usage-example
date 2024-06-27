import os

EXAMPLE_ENVIRONMENT_VARIABLE = os.getenv("EXAMPLE_ENVIRONMENT_VARIABLE", default=None)

if EXAMPLE_ENVIRONMENT_VARIABLE is None:
    print("EXAMPLE_ENVIRONMENT_VARIABLE is not set")
    print('Copy the ".env.example" file to a ".env" file and set the', end=" ")
    print("EXAMPLE_ENVIRONMENT_VARIABLE variable")
    exit(1)

print(f"{EXAMPLE_ENVIRONMENT_VARIABLE=}")
