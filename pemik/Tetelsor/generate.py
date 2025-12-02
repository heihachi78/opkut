import json;

with open("tetelsor.json") as f:
    data = json.load(f)

def v(person,subject): return f"{person}_{subject}"

with open("tetelsor_generated.mod", "w") as f:
    for p in data["people"]:
        for s in data["subjects"]:
            f.write(f"var {v(p,s)} binary;\n")
    f.write("var legtobbmunka >= 0;\n")

    for s in data["subjects"]:
        f.write(f"s.t. {s}_meg_kell_csinalni: ")
        f.write(" + ".join([v(p,s) for p in data["people"]]))
        f.write(" = 1;\n")

    for p in data["people"]:
        f.write(f"s.t. {p}_mennyit_dolgozik:\n")
        f.write("  legtobbmunka >= ")
        f.write(" + ".join([f"{data['worktime'][p][s]} * {v(p,s)}" for s in data["subjects"]]))
        f.write(";\n")
    
    f.write("minimize Hatarido: legtobbmunka;\n\n")



