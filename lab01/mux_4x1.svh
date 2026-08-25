module mux
  (
    output logic f,
    input  logic a, b, c, d, sel1, sel2
  ); 

  and g1(f1, a, sel1, sel2),
      g2(f2, b, sel1, n_sel2),
      g3(f3, c, n_sel1, sel2),
      g4(f4, d, n_sel1, n_sel2);
  or  (f, f1, f2, f3, f4);
  not g8(n_sel1, sel1),
      g9(n_sel2, sel2);
    

endmodule

