package br.com.vitor.app_trabalho;

import io.flutter.embedding.android.FlutterActivity;

import android.util.Log;

import androidx.annotation.NonNull;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;


public class MainActivity extends FlutterActivity {

    private static final String CHANNEL = "channel";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {

                            switch (call.method) {

                                case "_soma":
                                   
                                    int valora = Integer.parseInt(call.argument("valora"));
                                    int valorb = Integer.parseInt(call.argument("valorb"));

                                    int valor = (valora + valorb);
                                    result.success(valor);
                                    break;

                                case "_calcSalario":
                                    
                                    //int venda = Integer.parseInt(call.argument("venda"));
                                    //int salario = Integer.parseInt(call.argument("salario"));
                                    double salario = Double.parseDouble(call.argument("salario"));
                                    double venda = Double.parseDouble(call.argument("venda"));

                                    double comissao = venda * 0.15;
                                    double total = salario + comissao;
                                    //total = total.replaceAll(".", ",");
                                    result.success(total);
                                    break;

                                case "_calcNotas":
                                  
                                   int nota = Integer.parseInt(call.argument("nota"));
                                    
                                   List<Integer> notas = new ArrayList<Integer>();
                                    
                                   //System.out.println(nota);

                                   notas.add(nota / 100);
                                   nota = nota % 100; 
                                   notas.add(nota / 50);
                                   nota = nota % 50;
                                   notas.add(nota / 20);
                                   nota = nota % 20;
                                   notas.add(nota / 10);
                                   nota = nota % 10;
                                   notas.add(nota / 5);
                                   nota = nota % 5;
                                   notas.add(nota / 2);
                                   nota = nota % 2;
                                   notas.add(nota / 1);

                                    result.success(notas);
                                    break;

                                case "_calcConceito":

                                    int notaConceito = Integer.parseInt(call.argument("nota"));

                                    String conceito = "";

                                    if (notaConceito == 0) {
                                        conceito = "E";
                                    }
                                    if (notaConceito >= 1 && notaConceito <= 35) {
                                        conceito = "D";
                                    }
                                    if (notaConceito >= 36 && notaConceito <= 60) {
                                        conceito = "C";
                                    }
                                    if (notaConceito >= 61 && notaConceito <= 85) {
                                        conceito = "B";
                                    }
                                    if (notaConceito >= 86 && notaConceito <= 100) {
                                        conceito = "A";
                                    }
                                    result.success(conceito);

                                    break;

                                case "_calcSimNao":
                                    
                                    int h = Integer.parseInt(call.argument("h"));
                                    int d = Integer.parseInt(call.argument("d"));
                                    int g = Integer.parseInt(call.argument("g"));
                                    
                                   String simNao;
                                 
                                        if (h >= 200 && h <= 300) 
                                        {
                                            if (d >= 50 && g >= 150)
                                            {
                                                simNao = "Sim";
                                            }else
                                            {
                                                simNao = "Nao";
                                            }
                                        } else 
                                        {
                                            simNao = "Nao";
                                        }

                                    result.success(simNao);
                                    break;

                                default:
                                    result.notImplemented();

                            }
                        }
                );

    }
}