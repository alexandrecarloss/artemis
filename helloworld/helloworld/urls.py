from django.conf import settings
from django.contrib import admin
from django.urls import include, path
from adocao import views as adocaoViews
from django.conf.urls.static import static
from udemydrf.urls import router

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', adocaoViews.index, name='index'),
    path('adocao/', include('adocao.urls')),
    path('accounts/', include('accounts.urls')),
    path('venda/', include('venda.urls')),
    path('load_racas/', adocaoViews.load_racas, name="load_racas"),
    path('auth/', include('rest_framework.urls')),
    path('api/v1/', include('udemydrf.urls')),
    path('api/v2/', include(router.urls)),
]
urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

if settings.DEBUG:
    import debug_toolbar
    urlpatterns = [
        path('__debug__/', include(debug_toolbar.urls)),
    ] + urlpatterns

