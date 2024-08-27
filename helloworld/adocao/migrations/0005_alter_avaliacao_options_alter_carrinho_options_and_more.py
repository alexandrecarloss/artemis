# Generated by Django 5.0.3 on 2024-08-03 13:17

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('adocao', '0004_carrinho_servicofoto_solicita'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='avaliacao',
            options={'managed': False, 'ordering': ['avacod']},
        ),
        migrations.AlterModelOptions(
            name='carrinho',
            options={'managed': False, 'ordering': ['carid']},
        ),
        migrations.AlterModelOptions(
            name='formapagamento',
            options={'managed': False, 'ordering': ['fpgid']},
        ),
        migrations.AlterModelOptions(
            name='itemvenda',
            options={'managed': False, 'ordering': ['itemvenda_venid']},
        ),
        migrations.AlterModelOptions(
            name='login',
            options={'managed': False, 'ordering': ['logemail']},
        ),
        migrations.AlterModelOptions(
            name='notafiscal',
            options={'managed': False, 'ordering': ['ntfcod']},
        ),
        migrations.AlterModelOptions(
            name='ong',
            options={'managed': False, 'ordering': ['ongid']},
        ),
        migrations.AlterModelOptions(
            name='pessoa',
            options={'managed': False, 'ordering': ['pesid']},
        ),
        migrations.AlterModelOptions(
            name='pet',
            options={'managed': False, 'ordering': ['petid']},
        ),
        migrations.AlterModelOptions(
            name='petadocao',
            options={'managed': False, 'ordering': ['adoid']},
        ),
        migrations.AlterModelOptions(
            name='petfoto',
            options={'managed': False, 'ordering': ['pftid']},
        ),
        migrations.AlterModelOptions(
            name='petporte',
            options={'managed': False, 'ordering': ['ptpid']},
        ),
        migrations.AlterModelOptions(
            name='petraca',
            options={'managed': False, 'ordering': ['ptrid']},
        ),
        migrations.AlterModelOptions(
            name='petshop',
            options={'managed': False, 'ordering': ['ptsid']},
        ),
        migrations.AlterModelOptions(
            name='pettipo',
            options={'managed': False, 'ordering': ['pttid']},
        ),
        migrations.AlterModelOptions(
            name='produto',
            options={'managed': False, 'ordering': ['proid']},
        ),
        migrations.AlterModelOptions(
            name='produtofoto',
            options={'managed': False, 'ordering': ['prfid']},
        ),
        migrations.AlterModelOptions(
            name='servico',
            options={'managed': False, 'ordering': ['serid']},
        ),
        migrations.AlterModelOptions(
            name='servicofoto',
            options={'managed': False, 'ordering': ['serftid']},
        ),
        migrations.AlterModelOptions(
            name='solicita',
            options={'managed': False, 'ordering': ['solid']},
        ),
        migrations.AlterModelOptions(
            name='tiposervico',
            options={'managed': False, 'ordering': ['tpsid']},
        ),
        migrations.AlterModelOptions(
            name='venda',
            options={'managed': False, 'ordering': ['venid']},
        ),
    ]
