from collections import defaultdict

class NameMap:
    def __init__(self):
        self.name_map = defaultdict(lambda: None)

    def add_name_original(self, name:str):
        self.name_map[name] = None

    def add_name(self, name:str, new_name:str):
        if name == new_name:
            self.add_name_original(name)
        else:
            old = self.name_map[name]
            self.name_map[name] = new_name
            self.name_map[new_name] = old

    def get_name(self, name):
        if self.name_map.get(name) is None:
            return name
        else:
            while self.name_map.get(name) is not None:
                name = self.name_map[name]
            return name

def test_NameMap():
    input_sequence = [
        ("section", "section_class"),
        ("section_class", "section_class_course"),
        ("section_class_course", "section_class_course_time_slot"),
    ]
    nm = NameMap()
    for name, new_name in input_sequence:
        nm.add_name(name, new_name)
    for name in nm.name_map.keys():
        assert nm.get_name(name) == "section_class_course_time_slot"

if __name__ == "__main__":
    test_NameMap()