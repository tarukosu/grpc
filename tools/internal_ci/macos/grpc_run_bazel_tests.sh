#!/usr/bin/env bash
# Copyright 2019 The gRPC Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -ex

# change to grpc repo root
cd $(dirname $0)/../../..


./tools/run_tests/start_port_server.py

# run cfstream_test separately because it messes with the network
bazel test --spawn_strategy=standalone --genrule_strategy=standalone --test_output=all //test/cpp/end2end:cfstream_test

# kill port_server.py to prevent the build from hanging
ps aux | grep port_server\\.py | awk '{print $2}' | xargs kill -9

