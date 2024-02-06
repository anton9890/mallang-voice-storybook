from datasets import Dataset, DatasetDict
import json

class Datasets:
    def __init__(self, data_path, push_to_hub=False):
        # open json file
        with open(data_path, "r", encoding="utf-8") as file:
            self.data_path = json.load(file)
        self.ds = Dataset.from_dict({"audio": [path for path in self.data_path["audio"]["array"]],
                                     "transcripts": [transcript for transcript in self.data_path["sentence"]]})
        self.dataset = self.split(self.ds, push_to_hub=push_to_hub)

    def split(self, test_size=0.2, push_to_hub=False):
        train_testvalid = self.ds.train_test_split(test_size=test_size)
        test_valid = train_testvalid["test"].train_test_split(test_size=0.5)
        datasets = DatasetDict({
            "train": train_testvalid["train"],
            "test": test_valid["test"],
            "valid": test_valid["train"]})
        if push_to_hub:
            datasets.push_to_hub("업로드할 허깅페이스 주소 입력")
        return datasets
    
