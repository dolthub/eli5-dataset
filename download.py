import json
import os
import sys

import numpy as np
from nlp import load_dataset
import pandas as pd

class NumpyEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, np.ndarray):
            obj = obj.tolist()
            return NumpyEncoder.default(self, obj)
        elif isinstance(obj, list):
            return obj
        return json.JSONEncoder.default(self, obj)


if __name__=="__main__":
    _, output_path = sys.argv

    dataset = load_dataset("eli5")

    subrs = ["eli5", "asks", "askh"]
    train_partitions = ["train", "test", "validation"]
    json_cols = ["answers", "title_urls", "selftext_urls", "answers_urls"]

    for p in train_partitions:
        sec_path = os.path.join(output_path, f"{p}.csv")
        dfs = []
        for r in subrs:
            data = dataset[f"{p}_{r}"].data.to_pandas()
            for col in json_cols:
                data[col] = data[col].map(lambda x: json.dumps(x, cls=NumpyEncoder))
            dfs.append(data)
        pd.concat(dfs).to_csv(sec_path, index=False)

