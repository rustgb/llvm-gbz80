//===- GBZ80InstPrinter.h - Convert GBZ80 MCInst to assembly syntax -*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This class prints an GBZ80 MCInst to a .s file.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_GBZ80_INST_PRINTER_H
#define LLVM_GBZ80_INST_PRINTER_H

#include "llvm/MC/MCInstPrinter.h"

#include "MCTargetDesc/GBZ80MCTargetDesc.h"

namespace llvm {

/// Prints GBZ80 instructions to a textual stream.
class GBZ80InstPrinter : public MCInstPrinter {
public:
  GBZ80InstPrinter(const MCAsmInfo &MAI, const MCInstrInfo &MII,
                 const MCRegisterInfo &MRI)
      : MCInstPrinter(MAI, MII, MRI) {}

  void printInst(const MCInst *MI, raw_ostream &O, StringRef Annot,
                 const MCSubtargetInfo &STI) override;

  static const char *getPrettyRegisterName(unsigned RegNo);

private:
  static const char *getRegisterName(unsigned RegNo);
  void printOperand(const MCInst *MI, unsigned OpNo, raw_ostream &O);
  void printPCRelImm(const MCInst *MI, unsigned OpNo, raw_ostream &O);
  void printMemri(const MCInst *MI, unsigned OpNo, raw_ostream &O);
  void printCondCode(const MCInst *MI, unsigned OpNo, raw_ostream &O);

  // Autogenerated by TableGen.
  void printInstruction(const MCInst *MI, raw_ostream &O);
  bool printAliasInstr(const MCInst *MI, raw_ostream &O);
  void printCustomAliasOperand(const MCInst *MI, unsigned OpIdx,
                               unsigned PrintMethodIdx, raw_ostream &O);
};

} // end namespace llvm

#endif // LLVM_GBZ80_INST_PRINTER_H

