from app.config import AppSettings


def test_app_settings():
    app_settings = AppSettings()
    assert app_settings
