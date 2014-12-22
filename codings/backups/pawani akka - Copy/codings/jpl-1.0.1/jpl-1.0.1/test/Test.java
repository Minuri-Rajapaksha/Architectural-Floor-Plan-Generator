//tabstop=4
//*****************************************************************************/
// Project: jpl
//
// File:    $Id: Test.java,v 1.7 1999/05/05 13:46:41 fadushin Exp $
// Date:    $Date: 1999/05/05 13:46:41 $
// Author:  Fred Dushin <fadushin@syr.edu>
//          
//
// Description:
//    
//
// -------------------------------------------------------------------------
// Copyright (c) 1998 Fred Dushin
//                    All rights reserved.
// 
// This library is free software; you can redistribute it and/or
// modify it under the terms of the GNU Library Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
// 
// This library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Library Public License for more details.
//*****************************************************************************/



import java.util.Hashtable;
import jpl.*;

public class Test
{
	public static void
	main( java.lang.String argv[] )
	{
		JPL.init();
		
		run_tests();
	}
	
	static void
	run_tests()
	{
		test_0();
		test_1();
		test_2();
		test_3();
		test_4();
		test_5();
		test_6();
		test_7();
		test_8();
		test_9();
		test_10();
		test_11();
		
		test_101();
	}
	
	static void
	test_0()
	{
		System.out.print( "test 0..." );
		Query query = 
			new Query( 
				"consult", 
				Util.toTermArray(
					new Atom( "test.pl" ) ) );

		if ( !query.query() ){
			System.out.println( "consult( 'test.pl' ) failed" );
			System.exit( 1 );
		}
		System.out.println( "passed." );
	}
	
	static Term a = 
		new Atom( "a" );
	static Term b = 
		new Atom( "b" );
	static Term f_a = 
		new Compound(
			"f",
			Util.toTermArray( a ) );
	static Term pair_a_b =
		new Tuple(
			Util.toTermArray(
				a, b ) );
						
	static void
	test_1()
	{
		System.out.print( "test 1..." );
		Query query = 
			new Query( 
				"p", 
				Util.toTermArray(
					a ) );

		if ( !query.query() ){
			System.out.println( "p( a ) failed" );
			System.exit( 1 );
		}
		System.out.println( "passed." );
	}
						
	static void
	test_2()
	{
		System.out.print( "test 2..." );
		Query query = 
			new Query( 
				"p", 
				Util.toTermArray( 
					f_a ) );

		if ( !query.query() ){
			System.out.println( "p( f( a ) ) failed" );
			System.exit( 1 );
		}
		System.out.println( "passed." );
	}
						
	static void
	test_3()
	{
		System.out.print( "test 3..." );
		Query query = 
			new Query( 
				"p", 
				Util.toTermArray( 
					pair_a_b ) );

		if ( !query.query() ){
			System.out.println( "p( (a,b) ) failed" );
			System.exit( 1 );
		}
		System.out.println( "passed." );
	}
						
	static void
	test_4()
	{
		System.out.print( "test 4..." );
		Variable X = new Variable();
		Query query = 
			new Query( 
				"p", 
				Util.toTermArray( 
					X ) );

		Term[] target = new Term[4];
		target[0] = a;
		target[1] = f_a;
		target[2] = pair_a_b;
		target[3] = new Variable();

		Hashtable[] solutions = query.allSolutions();
		
		if ( solutions.length != 4 ){
			System.out.println( "p( X ) failed:" );
			System.out.println( "\tExpected: 4 solutions" );
			System.out.println( "\tGot:      " + solutions.length );
			System.exit( 1 );
		}
		
		for ( int i = 0;  i < solutions.length-1;  ++i ){
			Object binding = solutions[i].get( X );
			if ( ! binding.equals( target[i] ) ){
				System.out.println( "p( X ) failed" );
				System.out.println( "\tExpected: " + target[i] );
				System.out.println( "\tGot:      " + binding );
				System.exit( 1 );
			}
		}

		System.out.println( "passed." );
	}
						
	static void
	test_5()
	{
		System.out.print( "test 5..." );
		Variable X = new Variable();
		Variable Y = new Variable();
		Query query = 
			new Query( 
				"p", 
				Util.toTermArray( 
					X, Y ) );

		Term[] x_target = new Term[2];
		x_target[0] = a;
		x_target[1] = a;
		Term[] y_target = new Term[2];
		y_target[0] = a;
		y_target[1] = b;

		Hashtable[] solutions = query.allSolutions();
		
		if ( solutions.length != 2 ){
			System.out.println( "p( X, Y ) failed:" );
			System.out.println( "\tExpected: 2 solutions" );
			System.out.println( "\tGot:      " + solutions.length );
			System.exit( 1 );
		}
		
		for ( int i = 0;  i < solutions.length;  ++i ){
			Object x_binding = solutions[i].get( X );
			if ( ! x_binding.equals( x_target[i] ) ){
				System.out.println( "p( X, Y ) failed:" );
				System.out.println( "\tExpected: " + x_target[i] );
				System.out.println( "\tGot:      " + x_binding );
				System.exit( 1 );
			} 
			Object y_binding = solutions[i].get( Y );
			if ( ! y_binding.equals( y_target[i] ) ){
				System.out.println( "p( X, Y ) failed:" );
				System.out.println( "\tExpected: " + y_target[i] );
				System.out.println( "\tGot:      " + y_binding );
				System.exit( 1 );
			} 
		}
		System.out.println( "passed." );
	}
						
	static void
	test_6()
	{
		System.out.print( "test 6..." );
		Variable X = new Variable();
		Query query = 
			new Query( 
				"p", 
				Util.toTermArray( 
					X, X ) );

		Term[] x_target = new Term[1];
		x_target[0] = a;

		Hashtable[] solutions = query.allSolutions();
		
		if ( solutions.length != 1 ){
			System.out.println( "p( X, X ) failed:" );
			System.out.println( "\tExpected: 1 solution" );
			System.out.println( "\tGot:      " + solutions.length );
			System.exit( 1 );
		}
		
		for ( int i = 0;  i < solutions.length;  ++i ){
			Object x_binding = solutions[i].get( X );
			if ( ! x_binding.equals( x_target[i] ) ){
				System.out.println( "p( X, X ) failed:" );
				System.out.println( "\tExpected: " + x_target[i] );
				System.out.println( "\tGot:      " + x_binding );
				System.exit( 1 );
			}
		}
		System.out.println( "passed." );
	}
						
	static void
	test_7()
	{
		System.out.print( "test 7..." );
		Variable X = new Variable();
		Variable Y = new Variable();
		Query query = 
			new Query( 
				"r", 
				Util.toTermArray( 
					new Compound(
						"f",
						Util.toTermArray(
							X, X ) ), 
					Y ) );

		Hashtable[] solutions = query.allSolutions();
		
		if ( solutions.length != 2 ){
			System.out.println( "r( f( X, X ), Y ) failed:" );
			System.out.println( "\tExpected: 2 solutions" );
			System.out.println( "\tGot:      " + solutions.length );
			System.exit( 1 );
		}
		
		Object x_binding, y_binding;
		
		x_binding = solutions[0].get( X );
		y_binding = solutions[0].get( Y );
		if ( x_binding != y_binding ){
			System.out.println( "r( f( X, X ), Y ) failed:" );
			System.out.println( Util.toString( solutions[0] ) );
			System.out.println( "\tThe variables to which X and Y are bound in the first solution should be identical." );
			System.exit( 1 );
		}
		
		x_binding = solutions[1].get( X );
		y_binding = solutions[1].get( Y );
		if ( x_binding == y_binding ){
			System.out.println( "r( f( X, X ), Y ) failed:" );
			System.out.println( Util.toString( solutions[1] ) );
			System.out.println( "\tThe variables to which X and Y are bound in the second solution should be distinct." );
			System.exit( 1 );
		}
		if ( x_binding.equals( y_binding ) ){
			System.out.println( "r( f( X, X ), Y ) failed:" );
			System.out.println( Util.toString( solutions[1] ) );
			System.out.println( "\tThe variables to which X and Y are bound in the second solution should not be \"equal\"." );
			System.exit( 1 );
		}
		
		if ( ! solutions[0].get( X ).equals( solutions[1].get( X ) ) ){
			System.out.println( "r( f( X, X ), Y ) failed:" );
			System.out.println( Util.toString( solutions[0] ) );
			System.out.println( 
				"\tThe variable to which X is bound in the first solution\n" +
				"\tshould be equal to the variable to which X is bound in the second." );
			System.exit( 1 );
		}

		System.out.println( "passed." );
	}
						
	static void
	test_8()
	{
		System.out.print( "test 8..." );
		Variable X = new Variable();
		Query query = 
			new Query( 
				"r", 
				Util.toTermArray( 
					new Compound(
						"f",
						Util.toTermArray(
							X, X ) ), 
					X ) );

		Hashtable[] solutions = query.allSolutions();
		
		if ( solutions.length != 2 ){
			System.out.println( "r( f( X, X ), X ) failed:" );
			System.out.println( "\tExpected: 2 solutions" );
			System.out.println( "\tGot:      " + solutions.length );
			System.exit( 1 );
		}
		
		if ( ! solutions[0].get( X ).equals( solutions[1].get( X ) ) ){
			System.out.println( "r( f( X, X ), X ) failed:" );
			System.out.println( Util.toString( solutions[0] ) );
			System.out.println( 
				"\tThe variable to which X is bound in the first solution\n" +
				"\tshould be equal to the variable to which X is bound in the second." );
			System.exit( 1 );
		}
		
		System.out.println( "passed." );
	}
	
	// corresponds with Prolog List: [(a,a),(a,b)]
	static List test_9_solution =
		(List) Util.termArrayToList(
			Util.toTermArray(
				new Tuple.Pair( a, a ),
				new Tuple.Pair( a, b ) ) );
				
	static void
	test_9()
	{
		System.out.print( "test 9..." );
		Variable X   = new Variable();
		Variable Y   = new Variable();
		Variable XYs = new Variable();
		Query query = 
			new Query( 
				"bagof", 
				Util.toTermArray( 
					new Tuple.Pair( X, Y ),
					new Compound(
						"p",
						Util.toTermArray(
							X, Y ) ), 
					XYs ) );

		Hashtable[] solutions = query.allSolutions();
		
		if ( solutions.length != 1 ){
			System.out.println( "bagof( (X,Y), p(X, Y), XYs ) failed:" );
			System.out.println( "\tExpected: 1 solution" );
			System.out.println( "\tGot:      " + solutions.length );
			System.exit( 1 );
		}
		
		Term term = (Term) solutions[0].get( XYs );
		
		if ( ! (term instanceof List) ){
			System.out.println( "bagof( (X,Y), p(X, Y), XYs ) failed:" );
			System.out.println( "\tExpected: XYs to be a List" );
			System.out.println( "\tGot:      " + term );
			System.exit( 1 );
		}
		
		if ( ! term.equals( test_9_solution ) ){
			System.out.println( "bagof( (X,Y), p(X, Y), XYs ) failed:" );
			System.out.println( "\tExpected: " + test_9_solution );
			System.out.println( "\tGot:      " + term );
			System.exit( 1 );
		}
		
		System.out.println( "passed." );
	}
						
	static void
	test_10()
	{
		System.out.print( "test 10..." );
		Query query = 
			new Query( "t" );

		try {
			boolean b = query.query();
			System.out.println( "t failed:" );
			System.out.println( "\tExpected: JPLException" );
			System.out.println( "\tGot: " + b );
			System.exit( 1 );
		} catch ( PrologException e ){
		}
		
		System.out.println( "passed." );
	}
						
	static void
	test_11()
	{
		System.out.print( "test 11..." );
		Tuple tuple = 
			new Tuple( 
				new Atom( "a" ),
				new Atom( "b" ),
				new Atom( "c" ),
				new Atom( "d" ),
				new Atom( "e" ) );

		try {
			Variable  X = new Variable();
			Query query = new Query( "tuple", X );
			
			java.util.Hashtable solution = query.oneSolution();
			
			Tuple result = (Tuple) solution.get( X );
			
			if ( result == null || ! result.equals( tuple ) ){
				System.out.println( "failed:" );
				System.out.println( "\tresult: " + result );
				System.out.println( "\ttuple:  " + tuple );
				System.exit( 1 );
			}
			
			Term term;
			
			term = new Atom( "a" );
			if ( result.elt( 0 ) == null || !result.elt( 0 ).equals( term ) ){
				System.out.println( "failed:" );
				System.out.println( "\tresult.elt( 0 ): " + result.elt( 0 ) );
				System.out.println( "\tterm           : " + term );
				System.exit( 1 );
			}
			term = new Atom( "b" );
			if ( result.elt( 1 ) == null || !result.elt( 1 ).equals( term ) ){
				System.out.println( "failed:" );
				System.out.println( "\tresult.elt( 1 ): " + result.elt( 1 ) );
				System.out.println( "\tterm           : " + term );
				System.exit( 1 );
			}
			term = new Atom( "e" );
			if ( result.elt( 4 ) == null || !result.elt( 4 ).equals( term ) ){
				System.out.println( "failed:" );
				System.out.println( "\tresult.elt( 4 ): " + result.elt( 4 ) );
				System.out.println( "\tterm           : " + term );
				System.exit( 1 );
			}
			if ( result.elt( 6 ) != null ){
				System.out.println( "failed:" );
				System.out.println( "\tresult.elt( 6 ): " + result.elt( 6 ) );
				System.out.println( "\tshould be null" );
				System.exit( 1 );
			}
		} catch ( PrologException e ){
			System.out.println( "failed" );
			e.printStackTrace();
			System.exit( 1 );
		}
		
		System.out.println( "passed." );
	}
						
	static void
	test_101()
	{
		System.out.print( "test 101..." );
		Thread[] threads = new Thread[10];
		
		for ( int i = 0;  i < threads.length;  ++i ){
			threads[i] = new QueryThread( i );
		}
		for ( int i = 0;  i < threads.length;  ++i ){
			threads[i].start();
		}
		for ( int i = 0;  i < threads.length;  ++i ){
			try {
				threads[i].join();
			} catch ( InterruptedException ie ){
				ie.printStackTrace();
				System.exit( 1 );
			}
		}
		System.out.println( "passed." );
	}
	
	private static class
	QueryThread extends Thread
	{
		private int id_ = -1;

		public 
		QueryThread( int id )
		{
			this.id_ = id;
		}

		public java.lang.String
		toString()
		{
			return "(QueryThread id=" + id_ + ")";
		}
		
		
		public void
		run()
		{
			Query query = 
				new Query( 
					"p", 
					new Atom( "a" ), 
					new Atom( "a" ) );
			
			for ( int i = 0;  i < 10;  ++i ){
				try {
					query.query();
				} catch ( jpl.QueryInProgressException qipe ){
					System.out.println( "Threaded p( a, a ) failed using query: another Query in progress" );
					System.exit( 1 );
				}
				System.out.print( id_ );
				Thread.yield();
			}
			for ( int i = 0;  i < 10;  ++i ){
				synchronized ( Query.lock() ){
					try {
						while ( query.hasMoreSolutions() ){
							Thread.yield();
							query.nextSolution();
						}
					} catch ( jpl.QueryInProgressException qipe ){
						System.out.println( "Threaded p( a, a ) failed using loop: another Query in progress" );
						System.exit( 1 );
					}
					System.out.print( id_ );
				}
			}
		}
	}
	
	
	// more to come??
}
