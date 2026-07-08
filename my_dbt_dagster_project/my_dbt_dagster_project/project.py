from pathlib import Path
from dagster_dbt import DbtProject

project_root = Path(__file__).resolve().parents[2]

airbnb_project = DbtProject(
    project_dir=project_root / "airbnb",
    profiles_dir=project_root / "airbnb" / "_prod_profiles",
    packaged_project_dir=Path(__file__).resolve().parent.parent / "dbt-project",
)

airbnb_project.prepare_if_dev()